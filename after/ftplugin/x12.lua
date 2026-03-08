-- ftplugin/x12.lua
-- X12 EDI support for Neovim
-- Handles small and large files, virtual vs real line breaks, fast HL indent/folding
-- Adds STC visual status highlighting + inline explanations for 277CA, 835, 837

local max_file_size = 1024 * 1024 -- 1 MB threshold

-- buffer info
local buf = 0
local bufname = vim.api.nvim_buf_get_name(buf)

-- If buffer has no name yet, defer size detection
local stat
if bufname ~= "" then
    local ok
    ok, stat = pcall(vim.loop.fs_stat, bufname)
end

local is_large = stat and stat.size >= max_file_size

-- =============================
-- Indent and folding
-- =============================
vim.opt_local.indentexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
vim.opt_local.indentkeys = "0{,0},0),0],:,!^F,o,O,e"
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
vim.opt_local.foldlevel = 1
vim.opt_local.foldenable = true

-- =============================
-- Syntax
-- =============================
vim.cmd("syntax enable")

-- =============================
-- STC highlighting (277CA)
-- =============================
vim.api.nvim_set_hl(0, "X12STC_Accepted", { bg = "#1B5E20", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Info", { bg = "#F9A825", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Bad", { bg = "#B71C1C", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Accepted_Dim", { bg = "#2E7D32", fg = "white" })
vim.api.nvim_set_hl(0, "X12STC_Info_Dim", { bg = "#FFF59D", fg = "white" })
vim.api.nvim_set_hl(0, "X12STC_Bad_Dim", { bg = "#E57373", fg = "white" })

vim.fn.matchadd("X12STC_Accepted", "^STC\\*A2.*2000E")
vim.fn.matchadd("X12STC_Info", "^STC\\*A0.*2000E")
vim.fn.matchadd("X12STC_Bad", "^STC\\*A[^01].*2000E")
vim.fn.matchadd("X12STC_Accepted_Dim", "^STC\\*A2")
vim.fn.matchadd("X12STC_Info_Dim", "^STC\\*A0")
vim.fn.matchadd("X12STC_Bad_Dim", "^STC\\*A[^01]")

-- =============================
-- Small file: virtual line breaks
-- =============================
if not is_large then
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.showbreak = " "
    vim.opt_local.conceallevel = 2

    local ns = vim.api.nvim_create_namespace("x12_virtual_segments")
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for i, line in ipairs(lines) do
        for _, e in line:gmatch("()~()") do
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, e - 1, {
                virt_text = { { "", "Normal" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
            })
        end
    end

    vim.keymap.set("n", "<leader>aa", function()
        vim.opt_local.wrap = not vim.opt_local.wrap
    end, { buffer = true, desc = "Toggle virtual ~ line breaks" })
end

-- =============================
-- Large file: real line splits
-- =============================
local function large_file_split()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "\n")

    text = text:gsub("~(.)", "~\n%1")
    text = text:gsub("\n(HL)([*|])", "\n\n%1%2")
    text = text:gsub("\n(CLP)([*|])", "\n\n%1%2")

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { plain = true }))
end

if is_large then
    vim.treesitter.stop(buf)
    large_file_split()
end

-- =============================
-- Pretty preview for manual toggle
-- =============================
local function pretty_x12_preview()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local view = vim.fn.winsaveview()

    large_file_split()
    if is_large then
        print("X12 Pretty Preview applied (large-file mode)")
    else
        vim.opt_local.wrap = true
        print("X12 Pretty Preview applied (small-file mode, virtual ~ lines)")
    end

    vim.api.nvim_win_set_cursor(0, cursor)
    vim.fn.winrestview(view)
end

-- =============================
-- Keymaps
-- =============================
vim.keymap.set("n", "<leader>;", pretty_x12_preview, { buffer = true, desc = "X12: pretty segment preview" })
vim.keymap.set("n", "<leader>:", function()
    vim.cmd([[keepjumps %s/\~/\~\r/ge]])
end, { buffer = true, desc = "X12: break segments on ~" })

-- =============================
-- PHI Redaction (prefix-based)
-- - Provide a list of prefix patterns using "." as a wildcard separator
--   Example: "NM1.IL." matches "NM1*IL*" or "NM1|IL|"
-- - Visual mode: redact selection + copy redacted selection to system clipboard
-- - Normal mode: redact whole file, no clipboard copy
-- =============================

-- 1) Configure the prefixes you want to redact.
--    "." is intentionally used as a wildcard for one separator character.
local redact_prefixes = {
    "NM1.IL.",
    "NM1.QC.",
    "DMG.",
    "N3.",
    "N4.",
}

-- 2) Turn the user-friendly prefixes into Lua patterns.
--    In Lua patterns, "." already means "any character", so these strings
--    already work as patterns. We anchor to start-of-line (after optional whitespace).
local function redact_line(line)
    -- preserve leading whitespace (if any) so indentation isn't destroyed
    for _, prefix in ipairs(redact_prefixes) do
        -- match at beginning (allow leading spaces/tabs)
        local pat = "^(%s*)(" .. prefix .. ").*"
        if line:match(pat) then
            -- keep the matched prefix, replace the rest of the line with "REDACTED"
            return line:gsub(pat, "%1%2REDACTED")
        end
    end
    return line
end

local function redact_range(bufnr, start_lnum_0, end_lnum_0)
    -- end_lnum_0 is inclusive
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_lnum_0, end_lnum_0 + 1, false)
    for i = 1, #lines do
        lines[i] = redact_line(lines[i])
    end
    vim.api.nvim_buf_set_lines(bufnr, start_lnum_0, end_lnum_0 + 1, false, lines)
    return lines
end

local function redact_visual_and_copy()
    local bufnr = vim.api.nvim_get_current_buf()

    -- get visual selection bounds
    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")
    local srow, erow = s[2], e[2]

    if srow == 0 or erow == 0 then
        return
    end

    -- normalize order if selection was made bottom-to-top
    if srow > erow then
        srow, erow = erow, srow
    end

    -- convert to 0-based, inclusive range
    local start0 = srow - 1
    local end0 = erow - 1

    -- redact selected lines
    local redacted_lines = redact_range(bufnr, start0, end0)

    -- copy redacted selection to system clipboard register (+)
    -- (This works even if 'clipboard' isn't set to unnamedplus)
    vim.fn.setreg("+", table.concat(redacted_lines, "\n"))
    -- optional: also set the unnamed register so plain `p` pastes the same content
    -- vim.fn.setreg('"', table.concat(redacted_lines, "\n"))

    -- exit visual mode cleanly
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)

    vim.notify("X12: Redacted selection and copied to system clipboard (+).", vim.log.levels.INFO)
end

local function redact_entire_file()
    local bufnr = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    if line_count == 0 then
        return
    end

    -- redact whole buffer (0 .. line_count-1)
    redact_range(bufnr, 0, line_count - 1)
    vim.notify("X12: Redacted entire file (no clipboard copy).", vim.log.levels.INFO)
end

-- 3) Keymaps
-- Visual mode: redact selection + copy to clipboard
vim.keymap.set("v", "<leader>-", redact_visual_and_copy, {
    buffer = true,
    desc = "X12: redact selection (prefix map) + copy to clipboard",
})

-- Normal mode: redact entire file, no clipboard copy
vim.keymap.set("n", "<leader>-", redact_entire_file, {
    buffer = true,
    desc = "X12: redact entire file (prefix map)",
})

-- =============================
-- Unified Segment + Status Virtual Text
-- Supports 837 / 277 / 835 with STC loop-level hints
-- =============================
local segment_ns = vim.api.nvim_create_namespace("x12_segments")

local segments = {
    -- Generic segments
    -- ["AMT"] = "Dollar Amount",
    ["AMT.D"] = "Discount Amount",
    ["AMT.EAF"] = "Patient Paid Amount",
    ["CAS"] = "Adjustment amount",
    -- ["HL"] = "Hierarchical Level",
    ["SVC"] = "Service Line",
    ["BPR"] = "Payment Information",
    ["TRN"] = "Trace Number",
    ["N1.PE"] = "Payer Name",
    ["N1.PR"] = "Payee / Provider",
    ["N1.ZZ"] = "Additional Entity",
    ["N1"] = "Name Segment",
    -- ["N3"] = "Address",
    -- ["N4"] = "City/State/ZIP",
    ["REF.2U"] = "Payer ID",
    ["REF.EV"] = "Payer Claim Number",
    ["REF.F2"] = "Provider Tax ID",
    ["DTM"] = "Date/Time Reference",
    ["ADX"] = "Adjustment Information",
    ["AD1"] = "Adjustment Detail 1",
    ["AD2"] = "Adjustment Detail 2",
    ["PLB"] = "Provider Level Balances",
    ["DMG"] = "Demographic information (DOB and sex)",
    ["HI"] = "Diagnosis Codes",

    -- COB levels
    ["SBR.P"] = "Primary claim",
    ["SBR.S"] = "Secondary claim",
    ["SBR.T"] = "Tertiary claim",

    -- NM1 qualifiers
    ["NM1.77"] = "Facility",
    ["NM1.82"] = "Rendering Provider",
    ["NM1.85"] = "Billing Provider",
    ["NM1.87"] = "Pay-to Provider",
    ["NM1.IL"] = "Subscriber",
    ["NM1.QC"] = "Patient",
    ["NM1.PR"] = "Payer",
    ["NM1.DN"] = "Referring Provider",
    ["NM1.P3"] = "Primary Care Provider",
    ["PRV"] = "Taxonomy code",
    -- ["NM1"] = "Name Information",

    -- Dates
    ["DTP.472"] = "Service Date",
    ["DTP.434"] = "Statement Dates",
    ["DTP.050"] = "Received Date",
    ["DTP.009"] = "Processed Date",
    ["DTP.573"] = "Adjudication Date",
    ["DTP.435"] = "Admission Date",
    ["DTP.096"] = "Discharge Date",
    ["DTP.431"] = "Onset of Illness or Symptom",
    ["DTP.360"] = "Initial Treatment Date",
    ["DTP.304"] = "Last Seen Date",

    -- REF qualifiers
    ["REF.1K"] = "Payer Claim ID",
    ["REF.6R"] = "Provider Control Number",
    ["REF.EI"] = "Tax ID",
    ["REF.D9"] = "Claim Number",
    ["REF.F8"] = "Original Reference Number",
    -- ["REF"] = "Reference",

    -- STC / 835 status codes
    ["STC.A0"] = "Received / Informational Only",
    ["STC.A1"] = "Accepted for Adjudication / Paid",
    ["STC.A2"] = "Rejected / Denied",
    ["STC.A3"] = "Returned; Correction Required",
    ["STC.A6"] = "Acknowledgment Error",
    ["STC.A7"] = "Response Error",
}

-- -----------------------------
-- Split elements while preserving empty fields
-- -----------------------------
local function get_elements(line)
    local seg, sep = line:match("^%s*([A-Za-z0-9]+)([*|])")
    if not seg then
        return nil
    end

    local elements = {}
    local pattern = "(.-)" .. sep
    local last_end = 1

    for element, pos in line:gmatch(pattern .. "()") do
        table.insert(elements, element)
        last_end = pos
    end

    table.insert(elements, line:sub(last_end))
    elements[1] = elements[1]:upper() -- normalize segment ID
    return elements
end

-- -----------------------------
-- Resolve segment / qualifier / STC
-- -----------------------------
local function resolve_segment(elements, line)
    local seg = elements[1]
    local qualifier = elements[2]

    -- STC special handling
    if seg == "STC" and qualifier then
        local code, rest = qualifier:match("(%w+):?(%d*)")
        local key = "STC." .. code
        if segments[key] then
            local loop = line:match("2000E") and "Claim level"
                or line:match("2000D") and "Subscriber level"
                or line:match("2000C") and "Provider level"
                or "Envelope level"
            return segments[key] .. " (" .. loop .. ")"
        end
    end

    -- Segment + qualifier (e.g., NM1.82, REF.1K)
    if qualifier then
        local key = seg .. "." .. qualifier
        if segments[key] then
            return segments[key]
        end
    end

    -- fallback to generic segment
    return segments[seg]
end

-- -----------------------------
-- Renderer
-- -----------------------------
local function explain_segments()
    vim.api.nvim_buf_clear_namespace(buf, segment_ns, 0, -1)

    for lnum = 0, vim.api.nvim_buf_line_count(buf) - 1 do
        local line = vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1]
        if line then
            local elements = get_elements(line)
            if elements then
                local seg_msg = resolve_segment(elements, line)
                if seg_msg then
                    vim.api.nvim_buf_set_extmark(buf, segment_ns, lnum, 0, {
                        virt_text = { { "← " .. seg_msg, "Comment" } },
                        virt_text_pos = "eol",
                    })
                end
            end
        end
    end
end

-- -----------------------------
-- Autocmd for updates
-- -----------------------------
vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
    buffer = buf,
    callback = explain_segments,
})

-- ftplugin/x12.lua
-- X12 EDI support for Neovim
-- Handles small and large files, virtual vs real line breaks, fast HL indent/folding
-- Adds STC visual status highlighting + inline explanations for 277CA, 835, 837

-- =============================
-- Buffer handle (fix #1: never use 0 sentinel)
-- =============================
local buf = vim.api.nvim_get_current_buf()

-- =============================
-- File size detection
-- =============================
local max_file_size = 1024 * 1024 -- 1 MB threshold
local bufname = vim.api.nvim_buf_get_name(buf)
local stat
if bufname ~= "" then
    local ok
    ok, stat = pcall(vim.loop.fs_stat, bufname)
end
local is_large = stat and stat.size >= max_file_size

-- =============================
-- Indent and folding (fix #2: separate foldexpr from indentexpr)
-- =============================
vim.opt_local.indentexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
vim.opt_local.indentkeys = "0{,0},0),0],:,!^F,o,O,e"
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.require'indent.x12'.get_fold(v:lnum)"
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

    -- fix #3: batch extmarks; defer off the render hot-path
    vim.schedule(function()
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
    end)

    vim.keymap.set("n", "<leader>aa", function()
        vim.opt_local.wrap = not vim.opt_local.wrap:get()
    end, { buffer = true, desc = "Toggle virtual ~ line breaks" })
end

-- =============================
-- Large file: real line splits
-- fix #5: wrap in an undo block and guard against re-running
-- =============================
local function large_file_split()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "\n")
    text = text:gsub("~(.)", "~\n%1")
    text = text:gsub("\n(HL)([*|])", "\n\n%1%2")
    text = text:gsub("\n(CLP)([*|])", "\n\n%1%2")
    -- open a single undo block so the whole split is one <u> step
    vim.cmd("undojoin")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { plain = true }))
end

local split_done = vim.b[buf].x12_split_done
if is_large and not split_done then
    vim.treesitter.stop(buf)
    large_file_split()
    vim.b[buf].x12_split_done = true
end

-- =============================
-- Pretty preview for manual toggle
-- fix #6: re-seek to the segment ID at the cursor rather than restoring
--         a line number that is invalidated by the split
-- =============================
local function pretty_x12_preview()
    -- remember the segment ID on the cursor line so we can re-find it
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cursor_line = vim.api.nvim_buf_get_lines(buf, cursor[1] - 1, cursor[1], false)[1] or ""
    local anchor_seg = cursor_line:match("^%s*([A-Za-z0-9]+[*|])")

    large_file_split()

    -- try to land on the same segment after line numbers shift
    if anchor_seg then
        local escaped = vim.fn.escape(anchor_seg, "*|\\")
        pcall(vim.cmd, "keepjumps /" .. escaped)
    end

    if is_large then
        print("X12 Pretty Preview applied (large-file mode)")
    else
        vim.opt_local.wrap = true
        print("X12 Pretty Preview applied (small-file mode, virtual ~ lines)")
    end
end

-- =============================
-- Keymaps
-- =============================
vim.keymap.set("n", "<leader>;", pretty_x12_preview, {
    buffer = true,
    desc = "X12: pretty segment preview",
})
vim.keymap.set("n", "<leader>:", function()
    vim.cmd([[keepjumps %s/\~/\~\r/ge]])
end, { buffer = true, desc = "X12: break segments on ~" })

-- =============================
-- PHI Redaction (prefix-based)
-- - Provide a list of prefix patterns using "." as a wildcard separator.
--   "." is intentionally a Lua wildcard so it matches both "*" and "|"
--   element separators (e.g. "NM1.IL." matches "NM1*IL*" and "NM1|IL|").
--   This is deliberate — not a bug.
-- - Visual mode: redact selection + copy redacted selection to system clipboard
-- - Normal mode: redact whole file, no clipboard copy
-- - fix #7: redact up to the next "~" so unsplit files don't eat the whole
--   rest of the line
-- =============================
local redact_prefixes = {
    "NM1.IL.",
    "NM1.QC.",
    "DMG.",
    "N3.",
    "N4.",
}

local function redact_line(line)
    for _, prefix in ipairs(redact_prefixes) do
        -- Redact from end of prefix up to the next segment terminator (~) or EOL.
        -- The "." wildcard in prefix is intentional: matches * or | separators.
        local pat = "^(%s*)(" .. prefix .. ")[^~]*"
        if line:match(pat) then
            return line:gsub(pat, "%1%2REDACTED")
        end
    end
    return line
end

local function redact_range(bufnr, start_lnum_0, end_lnum_0)
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_lnum_0, end_lnum_0 + 1, false)
    for i = 1, #lines do
        lines[i] = redact_line(lines[i])
    end
    vim.api.nvim_buf_set_lines(bufnr, start_lnum_0, end_lnum_0 + 1, false, lines)
    return lines
end

local function redact_visual_and_copy()
    local bufnr = vim.api.nvim_get_current_buf()
    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")
    local srow, erow = s[2], e[2]
    if srow == 0 or erow == 0 then
        return
    end
    if srow > erow then
        srow, erow = erow, srow
    end
    local redacted_lines = redact_range(bufnr, srow - 1, erow - 1)
    vim.fn.setreg("+", table.concat(redacted_lines, "\n"))
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    vim.notify("X12: Redacted selection and copied to system clipboard (+).", vim.log.levels.INFO)
end

local function redact_entire_file()
    local bufnr = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    if line_count == 0 then
        return
    end
    redact_range(bufnr, 0, line_count - 1)
    vim.notify("X12: Redacted entire file (no clipboard copy).", vim.log.levels.INFO)
end

vim.keymap.set("v", "<leader>-", redact_visual_and_copy, {
    buffer = true,
    desc = "X12: redact selection (prefix map) + copy to clipboard",
})
vim.keymap.set("n", "<leader>-", redact_entire_file, {
    buffer = true,
    desc = "X12: redact entire file (prefix map)",
})

-- =============================
-- Unified Segment + Status Virtual Text
-- fix #8: segment data and resolution logic live in lua/x12/segments.lua;
--         this file only wires the renderer and autocmd.
-- Supports 837 / 277 / 835 with STC loop-level hints
-- =============================
local x12_seg = require("x12.segments")
local segment_ns = vim.api.nvim_create_namespace("x12_segments")

-- fix #4: render only the visible window range; debounce on text changes
local function explain_segments_range(first, last)
    vim.api.nvim_buf_clear_namespace(buf, segment_ns, first, last + 1)
    for lnum = first, last do
        local line = vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1]
        if line then
            local elements = x12_seg.get_elements(line)
            if elements then
                local seg_msg = x12_seg.resolve_segment(elements, line)
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

local function explain_visible()
    local first = vim.fn.line("w0") - 1
    local last = vim.fn.line("w$") - 1
    explain_segments_range(first, last)
end

-- debounce timer for text-change events
local debounce_timer = nil
local function explain_segments_debounced()
    if debounce_timer then
        debounce_timer:stop()
        debounce_timer:close()
    end
    debounce_timer = vim.defer_fn(explain_visible, 150)
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinScrolled" }, {
    buffer = buf,
    callback = explain_visible,
})
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    buffer = buf,
    callback = explain_segments_debounced,
})

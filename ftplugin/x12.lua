-- ftplugin/x12.lua
-- X12 EDI support for Neovim
-- Fast HL indent/folding
-- Adds STC visual status highlighting + inline explanations for 277CA, 835, 837
--
-- Change: no automatic formatting on open; no large vs small logic; no virtual line breaks.
-- Formatting only occurs when you press the mapped key (<leader>; or <leader>:).

-- =============================
-- Buffer handle (never use 0 sentinel)
-- =============================
local buf = vim.api.nvim_get_current_buf()

-- =============================
-- Indent and folding (separate foldexpr from indentexpr)
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
-- Pretty formatting (manual only)
-- Splits segments on ~ and adds extra blank lines before HL and CLP
-- Guarded so it does not re-run unless you reset b:x12_split_done
-- =============================
local function x12_pretty_split()
    if vim.b[buf].x12_split_done then
        return
    end

    -- For very large buffers, treesitter can amplify the cost during edits.
    -- Stop it only when you explicitly format.
    pcall(vim.treesitter.stop, buf)

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "\n")

    -- Insert newline after each segment terminator, preserve next char
    text = text:gsub("~(.)", "~\n%1")

    -- Visual grouping
    text = text:gsub("\n(HL)([*|])", "\n\n%1%2")
    text = text:gsub("\n(CLP)([*|])", "\n\n%1%2")

    -- Single undo step if possible
    pcall(vim.cmd, "silent! undojoin")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { plain = true }))

    vim.b[buf].x12_split_done = true
end

-- =============================
-- Pretty preview for manual toggle
-- Re-seek to the segment ID at the cursor rather than restoring a line number
-- =============================
local function pretty_x12_preview()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cursor_line = vim.api.nvim_buf_get_lines(buf, cursor[1] - 1, cursor[1], false)[1] or ""
    local anchor_seg = cursor_line:match("^%s*([A-Za-z0-9]+[*|])")

    x12_pretty_split()

    if anchor_seg then
        local escaped = vim.fn.escape(anchor_seg, "*|\\")
        pcall(vim.cmd, "keepjumps /" .. escaped)
    end

    vim.notify("X12 Pretty Preview applied", vim.log.levels.INFO)
end

-- =============================
-- Keymaps
-- =============================
vim.keymap.set("n", "<leader>;", pretty_x12_preview, {
    buffer = true,
    desc = "X12: pretty segment preview (manual)",
})

vim.keymap.set("n", "<leader>:", function()
    vim.cmd([[keepjumps %s/\~/\~\r/ge]])
end, { buffer = true, desc = "X12: break segments on ~ (manual)" })

-- =============================
-- PHI Redaction
-- Redacts the following fields:
--   NM1*IL / NM1*QC  — last name (NM103) and first name (NM104) only;
--                       all other elements including member ID are preserved
--   DMG              — full segment content after the first separator
--   N3               — full segment content (street address)
--   REF*SY           — Social Security Number
--   PER              — contact info (phone, email)
--
-- NM1 element positions:
--   1=segment id, 2=qualifier, 3=entity type, 4=last, 5=first, 6+=preserved
--
-- Implemented as an operator so it composes with any motion or text object:
--   <leader>r<motion>   e.g. <leader>rip, <leader>r5j, <leader>rG
--   <leader>rr          current line (doubled, like dd/yy)
--   <visual><leader>r   visual selection
-- =============================

local function redact_line(line)
    local seg_id, sep_char = line:match("^%s*([A-Za-z0-9]+)([*|])")
    if not seg_id then
        return line
    end
    seg_id = seg_id:upper()

    if seg_id == "NM1" then
        local parts = vim.split(line, sep_char, { plain = true })
        local qual = parts[2] or ""
        if qual == "IL" or qual == "QC" or qual == "71" then
            for i = 4, 6 do
                if parts[i] and parts[i] ~= "" then
                    parts[i] = "redacted"
                end
            end
            return table.concat(parts, sep_char)
        end
    elseif seg_id == "DMG" or seg_id == "N3" or seg_id == "N4" or seg_id == "PER" then
        local pat = "^(%s*" .. seg_id .. "[*|])[^~]*"
        if line:match(pat) then
            return line:gsub(pat, "%1redacted")
        end
    elseif seg_id == "REF" then
        local qual = (line:match("^%s*REF[*|]([^*|~]+)") or ""):upper()
        if qual == "SY" then
            local pat = "^(%s*REF[*|]SY[*|])[^~]*"
            if line:match(pat) then
                return line:gsub(pat, "%1redacted")
            end
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
end

_G.__x12_redact_operator = function(_motion_type)
    local s = vim.fn.getpos("'[")
    local e = vim.fn.getpos("']")
    local srow, erow = s[2] - 1, e[2] - 1
    redact_range(vim.api.nvim_get_current_buf(), srow, erow)
    vim.notify("X12: Redacted " .. (erow - srow + 1) .. " line(s).", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>r", function()
    vim.opt.operatorfunc = "v:lua.__x12_redact_operator"
    return "g@"
end, { buffer = true, expr = true, desc = "X12: redact PHI (operator)" })

vim.keymap.set("n", "<leader>rr", function()
    vim.opt.operatorfunc = "v:lua.__x12_redact_operator"
    return "g@_"
end, { buffer = true, expr = true, desc = "X12: redact PHI (current line)" })

vim.keymap.set("x", "<leader>r", function()
    vim.opt.operatorfunc = "v:lua.__x12_redact_operator"
    return "g@"
end, { buffer = true, expr = true, desc = "X12: redact PHI (visual)" })

-- =============================
-- Unified Segment + Status Virtual Text
-- Segment data and resolution logic live in lua/x12/segments.lua;
-- this file only wires the renderer and autocmd.
-- Supports 837 / 277 / 835 with STC loop-level hints
-- Defaults to OFF; toggle with <leader>vt
-- =============================
local x12_seg = require("x12.segments")
local segment_ns = vim.api.nvim_create_namespace("x12_segments")

local vt_enabled = false

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
    if not vt_enabled then
        return
    end
    local first = vim.fn.line("w0") - 1
    local last = vim.fn.line("w$") - 1
    explain_segments_range(first, last)
end

local debounce_timer = nil
local function explain_segments_debounced()
    if not vt_enabled then
        return
    end
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

vim.keymap.set("n", "<leader>vt", function()
    vt_enabled = not vt_enabled
    if vt_enabled then
        explain_visible()
        vim.notify("X12: segment virtual text ON", vim.log.levels.INFO)
    else
        vim.api.nvim_buf_clear_namespace(buf, segment_ns, 0, -1)
        vim.notify("X12: segment virtual text OFF", vim.log.levels.INFO)
    end
end, { buffer = true, desc = "X12: toggle segment virtual text" })

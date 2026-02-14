-- ftplugin/x12.lua
-- X12 EDI support for Neovim
-- Handles small and large files, virtual vs real line breaks, fast HL indent/folding
-- Adds STC visual status highlighting + inline explanations for 277CA

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

-- Highlight groups
-- vim.api.nvim_set_hl(0, "X12STC_Accepted", { fg = "#4CAF50", bold = truelaim Control Number
-- vim.api.nvim_set_hl(0, "X12STC_Info", { fg = "#FFC107", bold = true })
-- vim.api.nvim_set_hl(0, "X12STC_Bad", { fg = "#F44336", bold = true })

-- vim.api.nvim_set_hl(0, "X12STC_Accepted", { bg = "#1B5E20", fg = "white", bold = true })
-- vim.api.nvim_set_hl(0, "X12STC_Info",     { bg = "#F9A825", fg = "black", bold = true })
-- vim.api.nvim_set_hl(0, "X12STC_Bad",      { bg = "#B71C1C", fg = "white", bold = true })

vim.api.nvim_set_hl(0, "X12STC_Accepted", { bg = "#1B5E20", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Info", { bg = "#F9A825", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Bad", { bg = "#B71C1C", fg = "white", bold = true })
vim.api.nvim_set_hl(0, "X12STC_Accepted_Dim", { bg = "#2E7D32", fg = "white" })
vim.api.nvim_set_hl(0, "X12STC_Info_Dim", { bg = "#FFF59D", fg = "white" })
vim.api.nvim_set_hl(0, "X12STC_Bad_Dim", { bg = "#E57373", fg = "white" })

-- Match rules
-- vim.fn.matchadd("X12STC_Accepted", [[^STC\*A1:19]])
-- vim.fn.matchadd("X12STC_Info",     [[^STC\*A0]])
-- vim.fn.matchadd("X12STC_Bad",      [[^STC\*A[2367]]])
vim.fn.matchadd("X12STC_Accepted", "^STC\\*A1.*2000E")
vim.fn.matchadd("X12STC_Info", "^STC\\*A0.*2000E")
vim.fn.matchadd("X12STC_Bad", "^STC\\*A[^01].*2000E")
vim.fn.matchadd("X12STC_Accepted_Dim", "^STC\\*A1")
vim.fn.matchadd("X12STC_Info_Dim", "^STC\\*A0")
vim.fn.matchadd("X12STC_Bad_Dim", "^STC\\*A[^01]")

-- =============================
-- STC virtual text explanations
-- =============================

local stc_ns = vim.api.nvim_create_namespace("x12_stc")

local stc_meanings = {
    A0 = "Received / informational only",
    A1 = "Accepted for adjudication",
    A2 = "Rejected",
    A3 = "Returned; correction required",
    A6 = "Acknowledgement error",
    A7 = "Response error",
}

local function explain_stc()
    vim.api.nvim_buf_clear_namespace(buf, stc_ns, 0, -1)

    for lnum = 0, vim.api.nvim_buf_line_count(buf) - 1 do
        local line = vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1]
        local cat, code = line:match("^STC%*(%w+):(%d+)")

        if cat and code then
            -- local msg = stc_meanings[cat] or "Unknown status"
            local msg = (stc_meanings[cat] or "Unknown status")
            local loop = line:match("2000E") and "Claim level"
                or line:match("2000D") and "Subscriber level"
                or line:match("2000C") and "Provider level"
                or "Envelope level"
            msg = msg .. " (" .. loop .. ")"

            if cat == "A1" and code == "19" then
                msg = msg .. " (GOOD)"
            elseif code:match("^7") then
                msg = msg .. " (ERROR)"
            end

            vim.api.nvim_buf_set_extmark(buf, stc_ns, lnum, 0, {
                virt_text = { { "← " .. msg, "Comment" } },
                virt_text_pos = "eol",
            })
        end
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
    buffer = buf,
    callback = explain_stc,
})

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

    -- toggle virtual breaks
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

    -- newline after each segment terminator
    text = text:gsub("~", "~\n")

    -- extra blank line before HL segments
    text = text:gsub("\nHL%*", "\n\nHL*")

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

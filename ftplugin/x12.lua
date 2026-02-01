-- ftplugin/x12.lua

-- Limit for virtual line breaking
local max_file_size = 1024 * 1024 -- 1 MB

local bufname = vim.api.nvim_buf_get_name(0)
local ok, stat = pcall(vim.loop.fs_stat, bufname)
if not ok or not stat then
    return
end

-- Lua indent
vim.opt_local.indentexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
vim.opt_local.indentkeys = "0{,0},0),0],:,!^F,o,O,e"
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false

-- Syntax enable
vim.cmd("syntax enable")

-- Soft wrap / virtual breaks on ~ for small files
if stat.size <= max_file_size then
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.showbreak = " "
    vim.opt_local.conceallevel = 2

    local ns = vim.api.nvim_create_namespace("x12_virtual_segments")
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
        for s, e in line:gmatch("()~()") do
            vim.api.nvim_buf_set_extmark(0, ns, i - 1, e - 1, {
                virt_text = { { "", "Normal" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
            })
        end
    end

    -- Optional toggle
    vim.keymap.set("n", "<leader>v~", function()
        vim.opt_local.wrap = not vim.opt_local.wrap
    end, { buffer = true, desc = "Toggle virtual ~ line breaks" })
end

-- =====================================
-- X12 Pretty Preview (temporary)
-- =====================================

local function pretty_x12_preview()
    local buf = 0
    local ns_preview = vim.api.nvim_create_namespace("x12_preview")
    vim.api.nvim_buf_clear_namespace(buf, ns_preview, 0, -1)

    -- Save original cursor & view
    local cursor = vim.api.nvim_win_get_cursor(0)
    local view = vim.fn.winsaveview()

    -- Temporarily split segments on ~
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local new_lines = {}
    for _, line in ipairs(lines) do
        -- Split at ~ and keep ~ at the end of each segment
        for seg in line:gmatch("([^~]*~?)") do
            if seg ~= "" then
                table.insert(new_lines, seg)
            end
        end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)

    -- Re-apply syntax highlighting (optional but safer)
    vim.cmd("syntax enable")
    vim.cmd("filetype detect")

    -- Optional: fold HL hierarchies
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
    vim.opt_local.foldlevel = 1
    vim.opt_local.foldenable = true

    -- Restore cursor/view
    vim.api.nvim_win_set_cursor(0, cursor)
    vim.fn.winrestview(view)

    print("X12 Pretty Preview applied (undo to restore original)")
end

-- Map to <leader>p
vim.keymap.set("n", "<leader>;", pretty_x12_preview, {
    buffer = true,
    desc = "X12: pretty segment preview",
})

-- ftplugin/x12.lua
local viewer = require("x12.viewer")

-- Map <leader>v for virtual preview
vim.keymap.set("n", "<leader>vv", function()
    viewer.preview(0)
    print("X12 virtual preview applied")
end, { buffer = true, desc = "X12 virtual preview" })

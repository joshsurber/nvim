-- lua/indent/x12.lua
-- Fast indent logic for X12 EDI files (HL hierarchies)
-- Optimized for large files

local M = {}

-- Number of spaces per indent level
local indent_size = 4

-- Buffer-local table to store indent per line
-- key: buffer number, value: {indent per line}
local buf_indent_cache = {}

-- Compute indent table for the current buffer
local function compute_indent_table(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local indent_table = {}
    local hl_stack = {}

    for i, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)$")
        local indent = 0

        if trimmed:match("^HL%*") then
            local level = tonumber(trimmed:match("^HL%*([0-9]+)")) or 0
            hl_stack[#hl_stack + 1] = level
            indent = (#hl_stack - 1) * indent_size
        else
            indent = #hl_stack * indent_size
        end

        indent_table[i] = indent
    end

    buf_indent_cache[buf] = indent_table
end

-- Invalidate cache when buffer changes
vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "TextChangedI" }, {
    callback = function(args)
        buf_indent_cache[args.buf] = nil
    end,
})

-- Main indent function
function M.get_indent(lnum)
    local buf = 0 -- current buffer
    if not buf_indent_cache[buf] then
        compute_indent_table(buf)
    end

    return buf_indent_cache[buf][lnum] or 0
end

return M

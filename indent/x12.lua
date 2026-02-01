-- indent/x12.lua
local M = {}

-- HL segments increase indent; SE/GE/IEA decrease
local indent_increase = { HL = true }
local indent_decrease = { SE = true, GE = true, IEA = true }

function M.get_indent(lnum)
    if lnum == 1 then
        return 0
    end

    local prev = vim.fn.getline(lnum - 1)
    local curr = vim.fn.getline(lnum)

    local function seg(line)
        return line:match("^%s*([A-Z0-9][A-Z0-9][A-Z0-9]?)%*")
    end

    local prev_seg = seg(prev)
    local curr_seg = seg(curr)

    local indent = vim.fn.indent(lnum - 1)

    if prev_seg and indent_increase[prev_seg] then
        indent = indent + vim.o.shiftwidth
    end
    if curr_seg and indent_decrease[curr_seg] then
        indent = indent - vim.o.shiftwidth
    end

    return math.max(indent, 0)
end

return M

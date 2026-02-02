-- lua/x12/indent.lua
-- HL-based indentation for X12 / EDI

local M = {}

function M.get_indent(lnum)
    local level = 0

    for i = 1, lnum - 1 do
        local line = vim.fn.getline(i)

        -- Increase indent on HL
        if line:match("^HL%*") then
            level = level + 1

        -- Decrease indent at closing segments
        elseif line:match("^(SE%*|GE%*|IEA%*)") then
            level = math.max(level - 1, 0)
        end
    end

    return level * vim.bo.shiftwidth
end

return M

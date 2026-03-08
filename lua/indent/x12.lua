-- lua/indent/x12.lua
-- Indent and fold expression module for X12 EDI buffers.
-- Referenced by ftplugin/x12.lua via:
--   indentexpr = "v:lua.require'indent.x12'.get_indent(v:lnum)"
--   foldexpr   = "v:lua.require'indent.x12'.get_fold(v:lnum)"

local M = {}

-- =============================
-- Segment hierarchy used for indentation
-- =============================
-- Depth 0: transaction envelope  (ISA, GS, ST, SE, GE, IEA)
-- Depth 1: loop openers          (HL, CLM, CLP, SVC, NM1, N1 …)
-- Depth 2: loop detail           (everything else)

local ENVELOPE = { ISA = true, GS = true, ST = true, SE = true, GE = true, IEA = true }
local LOOP_OPEN = { HL = true, CLM = true, CLP = true, SVC = true }

local function seg_id(lnum)
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""
    return line:match("^%s*([A-Za-z0-9]+)[*|]")
end

-- =============================
-- get_indent(lnum) → column number
-- Called by indentexpr.
-- =============================
function M.get_indent(lnum)
    local id = seg_id(lnum)
    if not id then
        return 0
    end
    id = id:upper()
    if ENVELOPE[id] then
        return 0
    end
    if LOOP_OPEN[id] then
        return vim.bo.shiftwidth
    end
    return vim.bo.shiftwidth * 2
end

-- =============================
-- get_fold(lnum) → fold level string
-- Called by foldexpr.  Must return a fold-level token, not a column number.
-- =============================
function M.get_fold(lnum)
    local id = seg_id(lnum)
    if not id then
        return "="
    end
    id = id:upper()
    if ENVELOPE[id] then
        return "0"
    end
    if LOOP_OPEN[id] then
        return ">1"
    end -- start a new fold at level 1
    return "1" -- inside an open fold
end

return M

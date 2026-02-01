-- lua/x12/viewer.lua
-- X12 virtual viewer for large files

local M = {}

-- Segment coloring rules
M.hl_colors = {
    envelope = { segments = { "ISA", "GS", "ST", "SE", "GE", "IEA" }, hl = "Type" },
    claim = { segments = { "CLP", "NM1", "SVC", "CAS", "DTM" }, hl = "Identifier" },
    status = { segments = { "STC", "AAA", "IK3", "IK4", "IK5" }, hl = "Constant" },
}

-- Namespace for extmarks
M.ns = vim.api.nvim_create_namespace("x12_virtual_view")

-- Max file size to auto-enable (bytes)
M.max_file_size = 10 * 1024 * 1024 -- 10 MB

-- Split a line into virtual segments by ~
local function split_segments(line)
    local segments = {}
    for seg in line:gmatch("([^~]*~?)") do
        if seg ~= "" then
            table.insert(segments, seg)
        end
    end
    return segments
end

-- Determine highlight group for a segment ID
local function get_hl(segid)
    if not segid then
        return nil
    end
    for _, g in pairs(M.hl_colors) do
        for _, s in ipairs(g.segments) do
            if segid == s then
                return g.hl
            end
        end
    end
    return nil
end

-- Get segment ID from a segment string
local function get_seg_id(segment)
    return segment:match("^%s*([A-Z0-9]{2,5})")
end

-- Build virtual lines
function M.render_virtual_lines(bufnr)
    local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if not ok or not stat or stat.size > M.max_file_size then
        return
    end

    vim.api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local virt_lines = {}

    for i, line in ipairs(lines) do
        local col = 0
        for _, seg in ipairs(split_segments(line)) do
            local segid = get_seg_id(seg)
            local hlgroup = get_hl(segid) or "Normal"
            vim.api.nvim_buf_set_extmark(bufnr, M.ns, i - 1, col, {
                virt_text = { { seg, hlgroup } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
            })
            col = col + #seg
        end
    end
end

-- Fold HL hierarchy
function M.fold_hierarchy(bufnr)
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.require'x12.viewer'.foldexpr(v:lnum)"
    vim.opt_local.foldlevel = 1
    vim.opt_local.foldenable = true
end

-- Lua fold expression: HL segments increase depth, SE/GE/IEA decrease
function M.foldexpr(lnum)
    local line = vim.fn.getline(lnum)
    local segid = line:match("^%s*([A-Z0-9]{2,5})")
    if segid == "HL" then
        return ">" -- increase fold
    elseif segid == "SE" or segid == "GE" or segid == "IEA" then
        return "<" -- decrease fold
    else
        return "=" -- same fold level
    end
end

-- Entry point
function M.preview(bufnr)
    bufnr = bufnr or 0
    M.render_virtual_lines(bufnr)
    M.fold_hierarchy(bufnr)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.showbreak = " "
    vim.opt_local.conceallevel = 2
end

return M

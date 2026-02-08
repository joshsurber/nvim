-- ftplugin/x12.lua
-- X12 EDI support for Neovim
-- Handles small and large files, virtual vs real line breaks, fast HL indent/folding

local max_file_size = 1024 * 1024 -- 1 MB threshold

-- buffer info
local buf = 0
local bufname = vim.api.nvim_buf_get_name(buf)
local ok, stat = pcall(vim.loop.fs_stat, bufname)
if not ok or not stat then
    return
end
local is_large = stat.size >= max_file_size

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
        for s, e in line:gmatch("()~()") do
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
    -- optional: disable Treesitter for large files
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

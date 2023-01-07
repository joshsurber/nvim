-- https://github.com/chrisgrieser/nvim-various-textobjs
local ok, to = pcall(require, 'various-textobjs')
if not ok then return vim.notify('textobjects not loaded') end

to.setup({
    useDefaultKeymaps = false
})

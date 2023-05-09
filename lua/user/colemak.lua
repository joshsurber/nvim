Colemak=true

local function map(lhs, rhs)
    vim.keymap.set({ "n", "v" }, lhs, rhs, { remap = false })
end

map("j", "e")
map("k", "nzzzv")
map("l", "i")

map("K", "Nzzzv")
map("L", "I")
map('E', 'K')

map("n", "gj") -- Jump to next match
map("e", "gk") -- Go to end of word
map("i", "l") -- Enter insert mode

-- From mini.nvim
vim.keymap.set('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
vim.keymap.set('n', '<C-N>', '<C-w>j', { desc = 'Focus on below window' })
vim.keymap.set('n', '<C-E>', '<C-w>k', { desc = 'Focus on above window' })
vim.keymap.set('n', '<C-I>', '<C-w>l', { desc = 'Focus on right window' })

vim.keymap.set('c', '<M-h>', '<Left>', { silent = false, desc = 'Left' })
vim.keymap.set('c', '<M-i>', '<Right>', { silent = false, desc = 'Right' })

vim.keymap.set('i', '<M-h>', '<Left>', { noremap = false, desc = 'Left' })
vim.keymap.set('i', '<M-n>', '<Down>', { noremap = false, desc = 'Down' })
vim.keymap.set('i', '<M-e>', '<Up>', { noremap = false, desc = 'Up' })
vim.keymap.set('i', '<M-i>', '<Right>', { noremap = false, desc = 'Right' })

vim.keymap.set('t', '<M-h>', '<Left>', { desc = 'Left' })
vim.keymap.set('t', '<M-n>', '<Down>', { desc = 'Down' })
vim.keymap.set('t', '<M-e>', '<Up>', { desc = 'Up' })
vim.keymap.set('t', '<M-i>', '<Right>', { desc = 'Right' })

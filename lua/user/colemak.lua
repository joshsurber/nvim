Colemak = true

local map = vim.keymap.set
-- local function map(lhs, rhs)
--     vim.keymap.set({ "n", "v" }, lhs, rhs, { remap = false })
-- end

map("n", "j", "e")
map("n", "k", "nzzzv")
map("n", "l", "i")

map("n","K", "Nzzzv")
map("n","L", "I")
map("n",'E', 'K')

map("n", "n", "gj")
map("n", "e", "gk")
map("v", "n", "j")
map("v", "e", "k")
map("n", "i", "l")
map("v", "i", "l")
map("v", "o", "l")

-- map({ "n", "v" }, "M", "K")

-- From mini.nvim
map('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
map('n', '<C-N>', '<C-w>j', { desc = 'Focus on below window' })
map('n', '<C-E>', '<C-w>k', { desc = 'Focus on above window' })
map('n', '<C-I>', '<C-w>l', { desc = 'Focus on right window' })

map('c', '<M-h>', '<Left>', { silent = false, desc = 'Left' })
map('c', '<M-i>', '<Right>', { silent = false, desc = 'Right' })

map('i', '<M-h>', '<Left>', { noremap = false, desc = 'Left' })
map('i', '<M-n>', '<Down>', { noremap = false, desc = 'Down' })
map('i', '<M-e>', '<Up>', { noremap = false, desc = 'Up' })
map('i', '<M-i>', '<Right>', { noremap = false, desc = 'Right' })

map('t', '<M-h>', '<Left>', { desc = 'Left' })
map('t', '<M-n>', '<Down>', { desc = 'Down' })
map('t', '<M-e>', '<Up>', { desc = 'Up' })
map('t', '<M-i>', '<Right>', { desc = 'Right' })

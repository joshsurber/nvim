Colemak = true

local map = vim.keymap.set
-- local function map(lhs, rhs)
--     vim.keymap.set({ "n", "v" }, lhs, rhs, { remap = false })
-- end

map("n", "j", "e")
map("n", "k", "nzzzv")
map("n", "l", "i")

map("n", "L", "I")
map("n", "K", "Nzzzv")
map("n", 'E', 'K')

map("n", "n", "gj")
map("v", "n", "j")
map("n", "e", "gk")
map("v", "e", "k")
map("n", "i", "l")
map("v", "i", "l")
map("v", "o", "l")

-- map({ "n", "v" }, "M", "K")
-- vim.keymap.del("n", "<C-w>n")
-- vim.keymap.del("n", "<C-w>N")
-- vim.keymap.del("n", "<C-w>e")
-- vim.keymap.del("n", "<C-w>E")
-- vim.keymap.del("n", "<C-w>I")
map("n", "<C-w>l", "<C-w>i", { desc = 'Split and jump to declaration' })
map("n", "<C-w>n", "<C-w>j", { desc = 'Focus down' })
map("n", "<C-w>N", "<C-w>J", { desc = 'Move to very bottom' })
map("n", "<C-w>e", "<C-w>k", { desc = 'Focus up' })
map("n", "<C-w>E", "<C-w>K", { desc = 'Move to very top' })
map("n", "<C-w>i", "<C-w>l", { desc = 'Focus right' })
map("n", "<C-w>I", "<C-w>L", { desc = 'Move to very right' })
map("n", "<C-w>n", 'cmd nop')

-- From mini.nvim
map('n', '<C-h>', '<C-w>h', { desc = 'Focus on left window' })
map('n', '<C-n>', '<C-w>j', { desc = 'Focus on below window' })
map('n', '<C-e>', '<C-w>k', { desc = 'Focus on above window' })
map('n', '<C-i>', '<C-w>l', { desc = 'Focus on right window' })

map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Focus on left window' })
map('t', '<C-n>', '<C-\\><C-n><C-w>j', { desc = 'Focus on below window' })
map('t', '<C-e>', '<C-\\><C-n><C-w>k', { desc = 'Focus on above window' })
map('t', '<C-i>', '<C-\\><C-n><C-w>l', { desc = 'Focus on right window' })

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

map("n", '<S-h>', ':bprev<cr>', { silent = true })
map("n", '<S-i>', ':bnext<cr>', { silent = true })

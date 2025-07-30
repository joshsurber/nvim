-- local map = vim.keymap.set

-- Command line conveniences
vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set({ "n", "v" }, "<leader><leader>", "za", { desc = "Toggle fold" })

-- Searching nicities
vim.keymap.set("n", "*", "*N", { desc = "Search word under cursor" }) -- Fix * (Keep the cursor position, don't move to next match)
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" }
)
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>echo<cr>") --  remove search highlighting
-- vim.keymap.set("n", 'n', 'nzzzv', { desc = 'Go to next match' })      -- Fix n and N to...
-- vim.keymap.set("n", 'N', 'Nzzzv', { desc = 'Go to previous match' })  -- ...keep the cursor in center

-- Visual mode consistency
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "y", "y`]")
vim.keymap.set("v", "p", "p`]")
vim.keymap.set("n", "p", "p`]")

-- Execute lines
vim.keymap.set("n", "<leader>x", ":.lua<cr>", { desc = "Execute current line in lua" })
vim.keymap.set("v", "<leader>x", ":lua<cr>", { desc = "Execute selection in lua" })
vim.keymap.set("n", "<leader>X", "<cmd>source %<cr>", { desc = "Shout it out" })

-- Save and quit easier
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<cr>", { desc = "Save all windows/tabs" })
vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

vim.keymap.set("n", "<C-q>", ":q<cr>") -- Access `qq` macro
vim.keymap.set("n", "<leader>e", ":Lex<cr>", { desc = "Toggle NETRW file explorer" })
vim.keymap.set("n", "<leader>E", ":Lex<cr>", { desc = "Toggle NETRW file explrer" })
vim.keymap.set("n", "<leader>;", "^:s/\\~/&\\r/ge<cr>ggVG:s/HL\\*1\\*/\\r&/ge<cr>gg:set ft=x12<cr>", { desc = "Format X12" })

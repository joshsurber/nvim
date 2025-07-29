local map = vim.keymap.set

-- Command line conveniences
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
map("t", "<C-w>", "<C-\\><C-n><C-w>")
map({ "n", "v" }, "<leader><leader>", "za", { desc = "Toggle fold" })

-- Searching nicities
map("n", "*", "*N", { desc = "Search word under cursor" }) -- Fix * (Keep the cursor position, don't move to next match)
-- map("n", 'n', 'nzzzv', { desc = 'Go to next match' })      -- Fix n and N to...
-- map("n", 'N', 'Nzzzv', { desc = 'Go to previous match' })  -- ...keep the cursor in center
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("n", "<esc>", "<cmd>noh<cr><cmd>echo<cr>") --  remove search highlighting

-- -- Fix oddities with visual selections
-- -- Fix linewise visual selection of various text objects
-- map("n", "VV", "V", { desc = "Select visual lines" })
-- map("n", "Vit", "vitVkoj", { desc = "Select inside a tag" })
-- map("n", "Vat", "vatV", { desc = "Select around a tag" })
-- map("n", "Vab", "vabV", { desc = "Select a block" })
-- map("n", "VaB", "vaBV", { desc = "Select a block" })

-- Visual mode consistency
map("v", ">", ">gv")
map("v", "<", "<gv")
map("v", "y", "y`]")
map("v", "p", "p`]")
map("n", "p", "p`]")

-- Execute lines
map("n", "<leader>x", ":.lua<cr>", { desc = "Execute current line in lua" })
map("v", "<leader>x", ":lua<cr>", { desc = "Execute selection in lua" })
map("n", "<leader>X", "<cmd>source %<cr>", { desc = "Shout it out" })

-- Save and quit easier
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = "Save all windows/tabs" })
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

map("n", "<C-q>", ":q<cr>")
map("n", "<leader>e", ":Lex<cr>")
map("n", "<leader>E", ":Lex<cr>")

local map = vim.keymap.set

-- -- Easy access to edit init.lua
-- map("n", "<leader>ve", ":tabedit $MYVIMRC<cr>", { desc = 'Edit init.lua' })
-- map("n", "<leader>vs", ":source $MYVIMRC<cr>", { desc = 'Reload init.lua' })
-- map("n", "<leader>vd", ":cd ~/.config/nvim<cr>", { desc = 'Change to Neovim config directory' })

-- Command line conveniences
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
-- THIS DOESN'T WORK ANYMORE ANYWAY --
map("c", "w!!", "w !sudo tee % >/dev/null") -- No write permission? Fuck you, do it anyway!")
map("t", "<C-w>", "<C-\\><C-n><C-w>")
-- map('t', '<tab>', '<tab>')                    -- for some reason w/o this tab completion doesn't work
-- Folding
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

-- Go to end of visual selection
map("v", "y", "y`]")
map("v", "p", "p`]")
map("n", "p", "p`]")

-- Change modes easier
map("i", "nene", "<esc>")
map("t", "<Esc>", "<C-\\><C-n>")

-- Save and quit easier
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = "Save all windows/tabs" })
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
-- map("n", "<leader>Q", "<cmd>qall<cr>", { desc = 'Close all windows/tabs' })
-- map("n", "QQ", ":q<cr>")

map("n", "<C-q>", ":q<cr>") -- Access `qq` macro
map("n", "<leader>e", ":Lex<cr>", { desc = "Toggle NETRW file explorer" })
map("n", "<leader>E", ":Lex<cr>", { desc = "Toggle NETRW file explrer" })
map("n", "<leader>;", "^:s/\\~/&\\r/ge<cr>ggVG:s/HL\\*1\\*/\\r&/ge<cr>gg:set ft=x12<cr>", { desc = "Format X12" })

local map = vim.keymap.set

-- Easy access to edit init.lua
map("n", "<leader>ve", ":tabedit $MYVIMRC<cr>", { desc = 'Edit init.lua' })
map("n", "<leader>vs", ":source $MYVIMRC<cr>:PackerSync<cr>", { desc = 'Reload init.lua' })
map("n", "<leader>vd", ":cd ~/.config/nvim<cr>", { desc = 'Change to Neovim config directory' })
map("n", "<leader>vp", ":PackerSync<cr>", { desc = "Sync plugins" })

-- Window nav and resizing
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-Up>", ":resize +2<CR>", { desc = 'Make window taller' })
map("n", "<C-Down>", ":resize -2<CR>", { desc = 'Make window shorter' })
map("n", "<C-Left>", ":vertical resize +2<CR>", { desc = 'Make window wider' })
map("n", "<C-Right>", ":vertical resize -2<CR>", { desc = 'Make window narrower' })

-- map('n', '/', '/\\v')

-- Command line conveniences
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
map("c", "w!!", "w !sudo tee % >/dev/null") -- No write permission? Fuck you, do it anyway!")

-- leader-o/O inserts blank line below/above
map("n", '<leader>o', 'o<ESC>cc<ESC>', { desc = 'Insert blank line below' })
map("n", '<leader>O', 'O<ESC>cc<ESC>', { desc = 'Insert blank line above' })

-- Lines wrap. Deal with it...
map("n", "<DOWN>", "gj")
map("n", "<UP>", "gk")
map("", "<C-z>", ":set wrap!<CR>:set wrap?<CR>")

-- Folding
map({ 'n', 'v' }, "<leader><leader>", "za", { desc = 'Toggle fold' })

-- Searching nicities
map("n", '*', '*N', { desc = 'Search word under cursor' }) -- Fix * (Keep the cursor position, don't move to next match)
map("n", 'n', 'nzzzv', { desc = 'Go to next match' }) -- Fix n and N to...
map("n", 'N', 'Nzzzv', { desc = 'Go to previous match' }) -- ...keep the cursor in center
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("n", "<esc>", "<cmd>noh<cr>") --  remove search highlighting

-- Fix oddities with visual selections
-- Fix linewise visual selection of various text objects
map("n", "VV", "V", { desc = "Select visual lines" })
map("n", "Vit", "vitVkoj", { desc = "Select inside a tag" })
map("n", "Vat", "vatV", { desc = "Select around a tag" })
map("n", "Vab", "vabV", { desc = "Select a block" })
map("n", "VaB", "vaBV", { desc = "Select a block" })
--  Move to end of pasted text; easily select same
map("v", "y", "y`]", { desc = "Yank selection" })
map("v", "p", "p`]", { desc = "Replace selection with register (paste)" })
map("n", "p", "p`]", { desc = "Put buffer contents (paste)" })
map("n", "gV", "`[v`]", { desc = "Reselect last selection" })

-- -- don't leave visual selection mode after changing indentation
-- map("v", '>', '>gv', { desc = "Indent more" })
-- map("v", '<', '<gv', { desc = "Indent less" })
-- map("v", '=', '=gv', { desc = "Fix indentation" })

-- Easier access to system clipboard
map("n", '<leader>p', '"+p==', { desc = 'Paste from system clipboard' })
map("n", '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map("v", '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map("n", '<leader>P', '"+P==', { desc = 'Paste from system clipboard' })
map("n", '<leader>Y', '"+Y', { desc = 'Copy lines to system clipboard' })
map("v", '<leader>Y', '"+Y', { desc = 'Copy lines to system clipboard' })
map("x", "<leader>p", '"_dP', { desc = "Paste over selection without modifying registers" })

-- Change modes easier
map("i", "jk", "<esc>")
map("t", "<Esc>", "<C-\\><C-n>")

-- Save and quit easier
map("n", "<leader>w", "<cmd>w<cr>", { desc = 'Save' })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = 'Save all windows/tabs' })
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = 'Delete buffer' })
map("n", "<leader>Q", "<cmd>qall<cr>", { desc = 'Close all windows/tabs' })
map("n", "QQ", ":q<cr>")

-- -- Move line up and down in NORMAL and VISUAL modes
-- map("n", '<A-j>', '<CMD>move .+1<CR>==', { desc = "Move line down" })
-- map("n", '<A-k>', '<CMD>move .-2<CR>==', { desc = "Move line up" })
-- map("v", '<A-j>', ":move '>+1<CR>gv=gv", { desc = "Move line(s) down" })
-- map("v", '<A-k>', ":move '<-2<CR>gv=gv", { desc = "Move line(s) up" })
-- map("i", '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = "Move line down" })
-- map("i", '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = "Move line up" })
-- map("n", '<A-J>', 'yyp', { desc = "Duplicate line below" })
-- map("n", '<A-K>', 'yyP', { desc = "Duplicate line above" })

-- Simplify accessing keys chorded to my escape key
map('', '<A-ESC>', '~') -- Tilde is a third layer on my ESC key. Fuck that
map('!', '<A-ESC>', '~') -- Remap it in every way possible
map("i", '<A-\'>', '`') -- Backtick is also a function layer on esc. To hell with that shit

map("n", '<C-q>', '@q') -- Access `qq` macro

map("n", '<S-h>', ':bprev<cr>')
map("n", '<S-l>', ':bnext<cr>')

map("n", '<leader>e', ':Lexplore<CR>', { desc = 'Toggle file tree' })

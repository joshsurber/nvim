local function map(mode, shortcut, command) vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true }) end
local function nmap(shortcut, command) map('n', shortcut, command) end
local function imap(shortcut, command) map('i', shortcut, command) end
local function tmap(shortcut, command) map('t', shortcut, command) end
local function vmap(shortcut, command) map('v', shortcut, command) end

nmap('Y', 'yy')
--" Easy access to edit vimrc
nmap("<leader>ve", ":edit $MYVIMRC<cr>")
nmap("<leader>vs", ":source $MYVIMRC<cr>")
-- Control+HJKL navigates windows
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")
nmap("<C-Up>", ":resize +2<CR>")
nmap("<C-Down>", ":resize -2<CR>")
nmap("<C-Left>", ":vertical resize +2<CR>")
nmap("<C-Right>", ":vertical resize -2<CR>")
-- expand %% to current directory in command-line mode
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")
-- leader-o/O inserts blank line below/above
nmap('<leader>o', 'o<ESC>')
nmap('<leader>O', 'O<ESC>')

nmap("<leader>p", ":<C-u>FZF<CR>")
--" Lines wrap. Deal with it...
nmap("j", "gj")
nmap("k", "gk")
map("", "<C-z>", ":set wrap!<CR>:set wrap?<CR>")
--" Folding
nmap("<leader><leader>", "za")
vmap("<leader><leader>", "za")
--nmap("/", "/\\v")
--vmap("/", "/\\v")

-- Fix * (Keep the cursor position, don't move to next match)
nmap('*', '*N')
--
-- -- Fix n and N. Keeping cursor in center
nmap('n', 'nzz')
nmap('N', 'Nzz')

nmap("<tab>", "%")
--" remove search highlighting
nmap("<leader>\\", "<cmd>noh<cr>")
nmap("<esc>", "<cmd>noh<cr>")
--" Move to end of pasted text; easily select same
vmap("y", "y`]")
vmap("p", "p`]")
nmap("p", "p`]")
nmap("gV", "`[v`]")

nmap('<C-e>', ':Lexplore<CR>')

--" Fix linewise visual selection of various text objects
nmap("VV", "V")
nmap("Vit", "vitVkoj")
nmap("Vat", "vatV")
nmap("Vab", "vabV")
nmap("VaB", "vaBV")

imap("jk", "<esc>")
vmap("jk", "<esc>")
nmap("<leader>w", "<cmd>w<cr>")
nmap("<leader>W", "<cmd>wall<cr>")
nmap("<leader>qq", "<cmd>q<cr>")
nmap("<leader>Q", "<cmd>qall<cr>")
nmap("QQ", ":q<cr>")
map("c", "w!!", "w !sudo tee % >/dev/null") -- No write permission? Fuck you, do it anyway!")
-- Move line up and down in NORMAL and VISUAL modes
-- -- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
nmap('<C-j>', '<CMD>move .+1<CR>==')
nmap('<C-k>', '<CMD>move .-2<CR>==')
vmap('<C-j>', ":move '>+1<CR>gv=gv")
vmap('<C-k>', ":move '<-2<CR>gv=gv")
imap('<C-j>', '<Esc>:m .+1<CR>==gi')
imap('<C-k>', '<Esc>:m .-2<CR>==gi')
-- don't leave visual selection mode after changing indentation
vmap('>', '>gv')
vmap('<', '<gv')
vmap('=', '=gv')

-- Insert new line in normal mode
nmap('<S-CR>', 'i<CR><Esc>')
--run default macro (recorded with qq)
nmap('Q', '@q')

tmap("<Esc>", "<C-\\><C-n>")
--[[
tmap("<A-h>", "<C-\\><C-N><C-w>h")
tmap("<A-j>", "<C-\\><C-N><C-w>j")
tmap("<A-k>", "<C-\\><C-N><C-w>k")
tmap("<A-l>", "<C-\\><C-N><C-w>l")
imap("<A-h>", "<C-\\><C-N><C-w>h")
imap("<A-j>", "<C-\\><C-N><C-w>j")
imap("<A-k>", "<C-\\><C-N><C-w>k")
imap("<A-l>", "<C-\\><C-N><C-w>l")
nmap("<A-h>", "<C-w>h")
nmap("<A-j>", "<C-w>j")
nmap("<A-k>", "<C-w>k")
nmap("<A-l>", "<C-w>l")
]]
nmap('<leader>p', '"*p')
nmap('<leader>y', '"*y')
vmap('<leader>y', '"*y')
nmap('<leader>P', '"*P')
nmap('<leader>Y', '"*Y')
vmap('<leader>Y', '"*Y')

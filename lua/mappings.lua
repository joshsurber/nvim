--[[
set fdm=expr fde=getline(v\:lnum)=~'^\\s*$'&&getline(v\:lnum+1)=~'\\S'?'<1'\:1
]]

-- Convenience functions for setting mappings
local function map(mode, shortcut, command) vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true }) end

local function cmap(shortcut, command) map('c', shortcut, command) end

local function imap(shortcut, command) map('i', shortcut, command) end

local function nmap(shortcut, command) map('n', shortcut, command) end

local function tmap(shortcut, command) map('t', shortcut, command) end

local function vmap(shortcut, command) map('v', shortcut, command) end

-- You can have my Y when you pry it from my cold, dead hands!
vim.keymap.del('', 'Y')

-- Easy access to edit init.lua
nmap("<leader>ve", ":tabedit $MYVIMRC<cr>")
nmap("<leader>vs", ":source $MYVIMRC<cr>:PackerSync<cr>")
nmap("<leader>vp", ":PackerSync<cr>")

-- Window nav and resizing
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")
nmap("<C-Up>", ":resize +2<CR>")
nmap("<C-Down>", ":resize -2<CR>")
nmap("<C-Left>", ":vertical resize +2<CR>")
nmap("<C-Right>", ":vertical resize -2<CR>")

-- Command line conveniences
cmap("%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
cmap("w!!", "w !sudo tee % >/dev/null") -- No write permission? Fuck you, do it anyway!")

-- leader-o/O inserts blank line below/above
nmap('<leader>o', 'o<ESC>cc<ESC>')
nmap('<leader>O', 'O<ESC>cc<ESC>')

-- Lines wrap. Deal with it...
nmap("j", "gj")
nmap("k", "gk")
map("", "<C-z>", ":set wrap!<CR>:set wrap?<CR>")

--  Folding
map({ 'n', 'v' }, "<leader><leader>", "za")

-- Searching nicities
nmap('*', '*N') -- Fix * (Keep the cursor position, don't move to next match)
nmap('n', 'nzz') -- Fix n and N to...
nmap('N', 'Nzz') -- ...keep the cursor in center
nmap("<leader>\\", "<cmd>noh<cr>") --  remove search highlighting
nmap("<esc>", "<cmd>noh<cr>") --  remove search highlighting

--  Fix oddities with visual selections
--  Fix linewise visual selection of various text objects
nmap("VV", "V")
nmap("Vit", "vitVkoj")
nmap("Vat", "vatV")
nmap("Vab", "vabV")
nmap("VaB", "vaBV")
--  Move to end of pasted text; easily select same
vmap("y", "y`]")
vmap("p", "p`]")
nmap("p", "p`]")
nmap("gV", "`[v`]")
-- don't leave visual selection mode after changing indentation
vmap('>', '>gv')
vmap('<', '<gv')
vmap('=', '=gv')

-- Easier access to system clipboard
nmap('<leader>p', '"+p==')
nmap('<leader>y', '"+y')
vmap('<leader>y', '"+y')
nmap('<leader>P', '"+P==')
nmap('<leader>Y', '"+Y')
vmap('<leader>Y', '"+Y')

-- Change modes easier
imap("jk", "<esc>")
vmap("jkjk", "<esc>")
tmap("<Esc>", "<C-\\><C-n>")

-- Save and quit easier
nmap("<leader>w", "<cmd>w<cr>")
nmap("<leader>W", "<cmd>wall<cr>")
nmap("<leader>qq", "<cmd>q<cr>")
nmap("<leader>Q", "<cmd>qall<cr>")
nmap("QQ", ":q<cr>")

-- Move line up and down in NORMAL and VISUAL modes
-- -- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
nmap('<C-j>', '<CMD>move .+1<CR>==')
nmap('<C-k>', '<CMD>move .-2<CR>==')
vmap('<C-j>', ":move '>+1<CR>gv=gv")
vmap('<C-k>', ":move '<-2<CR>gv=gv")
imap('<C-j>', '<Esc>:m .+1<CR>==gi')
imap('<C-k>', '<Esc>:m .-2<CR>==gi')

-- Simplify accessing keys chorded to my escape key
map('!', '<A-ESC>', '~') -- Tilde is a third layer on my esc key. Fuck that
imap('<A-\'>', '`') -- Backtick is also a function layer on esc. To hell with that shit

nmap('Q', '@q') --run default macro (recorded with qq)

nmap("<tab>", "%")

nmap('<C-e>', ':Lexplore<CR>')

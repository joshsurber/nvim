--[[
set fdm=expr fde=getline(v\:lnum)=~'^\\s*$'&&getline(v\:lnum+1)=~'\\S'?'<1'\:1
]]

local function map(mode, shortcut, command, opts)
    local opts = opts or {}
    opts.noremap = true
    -- opts.silent = false
    vim.keymap.set(mode, shortcut, command, opts)
end

-- You can have my Y when you pry it from my cold, dead hands!
vim.keymap.del('', 'Y')

-- Easy access to edit init.lua
WKRegister('<leader>v', 'Neovim config')
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

map('n', '/', '/\\v')

-- Command line conveniences
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>") -- expand %% to current directory in command-line mode
map("c", "w!!", "w !sudo tee % >/dev/null") -- No write permission? Fuck you, do it anyway!")

-- leader-o/O inserts blank line below/above
map("n", '<leader>o', 'o<ESC>cc<ESC>', { desc = 'Insert blank line below' })
map("n", '<leader>O', 'O<ESC>cc<ESC>', { desc = 'Insert blank line above' })

-- Lines wrap. Deal with it...
map("n", "<DOWN>", "gj", { desc = "Down visual line" })
map("n", "<UP>", "gk", { desc = "Up visual lines" })
map("", "<C-z>", ":set wrap!<CR>:set wrap?<CR>", { desc = "Toggle word wrap" })

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
-- don't leave visual selection mode after changing indentation
map("v", '>', '>gv', { desc = "Indent more" })
map("v", '<', '<gv', { desc = "Indent less" })
map("v", '=', '=gv', { desc = "Fix indentation" })

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
-- map("v","jkjk", "<esc>")
map("t", "<Esc>", "<C-\\><C-n>")

-- Save and quit easier
map("n", "<leader>w", "<cmd>w<cr>", { desc = 'Save' })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = 'Save all windows/tabs' })
map("n", "<leader>q", "<cmd>Bdelete<cr>", { desc = 'Remove buffer (close tab)' })
map("n", "<leader>Q", "<cmd>qall<cr>", { desc = 'Close all windows/tabs' })
map("n", "QQ", ":q<cr>")
-- Move line up and down in NORMAL and VISUAL modes
-- -- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("n", '<A-j>', '<CMD>move .+1<CR>==', { desc = "Move line down" })
map("n", '<A-k>', '<CMD>move .-2<CR>==', { desc = "Move line up" })
map("v", '<A-j>', ":move '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("v", '<A-k>', ":move '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("i", '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = "Move line down" })
map("i", '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = "Move line up" })
map("n", '<A-J>', 'yyp', { desc = "Duplicate line below" })
map("n", '<A-K>', 'yyP', { desc = "Duplicate line above" })

-- Simplify accessing keys chorded to my escape key
map('', '<A-ESC>', '~') -- Tilde is a third layer on my ESC key. Fuck that
map('!', '<A-ESC>', '~') -- Remap it in every way possible
map("i", '<A-\'>', '`') -- Backtick is also a function layer on esc. To hell with that shit

map("n", '<C-q>', '@q', { desc = "run default macro (from qq)" })

-- map("n","<tab>", "%")

map("n", '<S-h>', ':bprev<cr>', { desc = "Previous buffer" })
map("n", '[b', ':bprev<cr>', { desc = "Next buffer" })
map("n", '<S-l>', ':bnext<cr>', { desc = "Previous buffer" })
map("n", ']b', ':bnext<cr>', { desc = "Next buffer" })

map("n", '<leader>e', ':Lexplore<CR>', { desc = 'Toggle file tree' })
-- This is for a weird bug I get with a single-line window and empty buffer
-- Hopefully will be fixed in future nvim release. FIXME delete if fixed
map("n", '<leader>_', ':Bdelete<cr>:resize<cr>', { desc = 'Fix window sizes' })


-- LSP mappings
WKRegister('<leader>l', 'LSP commands')
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Floating information window' })
map('n', 'gH', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Signature information floating window' })
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Go to definition' })
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Go to declaration' })
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'List implementations in quickfix window' })
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Go to type definition' })
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'List referencess in quickfix window' })
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol under cursor' })
map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Select a code action' })
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Format buffer' })
map('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'Show diagnostics in floating window' })
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Go to previous diagnostic' })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Go to next diagnostic' })

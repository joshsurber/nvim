--" Personal vimrc from Josh Surber http://github.com/joshsurber

vim.g.mapleader = " "

require('plugins')
--" lua require('vimplug')
require('settings')
require('mappings')
require('autocmds')

--" If we haven't installed gruvbox yet, use a build-in colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[silent! colorscheme evening]]
vim.cmd [[silent! colorscheme gruvbox]]
-- vim.cmd [[silent! colorscheme gruvbox-baby]]

-- Neovide config
vim.o.guifont = "CascadiaCode_Nerd_Font,Cascadia_Code_PL,Hack:h10"
vim.cmd [[
let g:neovide_floating_blur_amount_x = 50
let g:neovide_floating_blur_amount_y = 50
let g:neovide_cursor_vfx_mode = "railgun"
]]

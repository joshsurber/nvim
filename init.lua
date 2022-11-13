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
vim.cmd [[silent! colorscheme gruvbox-baby]]

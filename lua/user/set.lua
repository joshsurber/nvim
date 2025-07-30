vim.o.cindent = true -- Indent using C-style rules
vim.o.confirm = true -- Instead of failing a command because of unsaved changes raise a dialogue asking if you wish to save changed files.
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true -- Use spaces instead of tabs
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.o.foldcolumn = "auto"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 1
vim.o.foldnestmax = 3
vim.o.foldtext = ""
vim.o.guifont = "Cascadia Code NF:h9" -- For Neovide etc
-- guifont = "CaskaydiaCove NF:h9" -- For Neovide etc
vim.o.keywordprg = ":help" -- 'K' searches vim docs
vim.o.lazyredraw = true -- Don't redraw screen while executing macros
vim.o.relativenumber = true
vim.o.scrolloff = 3 -- Lines to keep on screen
vim.o.shiftwidth = 0 -- Spaces to use for autoindent. 0 uses tabstop value
vim.o.showbreak = "↪" -- Indicator at the start of wrapped lines
vim.o.showmatch = true -- Highlight matching brackets as you type
vim.o.sidescrolloff = 3 -- Min cols to keep on screen
vim.o.softtabstop = -1 -- If negative shiftwidth value is used
vim.o.swapfile = false -- How often does vim crash anyway?
vim.o.tabstop = 4 -- Spaces a tab is worth
vim.o.timeoutlen = 500 -- MS to wait for mapping to complete
-- vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Save undo history
vim.o.wildignorecase = true -- Case insensitive completion

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.t_co = 256

vim.g.nvim_markdown_preview_format = "markdown"

vim.g.netrw_sort_by = "time"
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_direction = "reverse"

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_hide_mouse_when_typing = true

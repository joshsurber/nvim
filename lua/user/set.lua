local o = vim.o
local g = vim.g
-- o.cindent = true -- Indent using C-style rules
o.confirm = true -- Instead of failing a command because of unsaved changes raise a dialogue asking if you wish to save changed files.
o.dictionary = "/usr/share/dict/words"
o.expandtab = true -- Use spaces instead of tabs
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
-- o.foldcolumn = "auto"
-- o.foldlevel = 99
-- o.foldlevelstart = 1
-- o.foldnestmax = 3
-- o.foldtext = ""
o.guifont = "Cascadia Code NF:h9" -- For Neovide etc
-- guifont = "CaskaydiaCove NF:h9" -- For Neovide etc
-- o.keywordprg = ":help" -- 'K' searches vim docs
o.lazyredraw = true -- Don't redraw screen while executing macros
-- o.relativenumber = true
o.scrolloff = 3 -- Lines to keep on screen
o.shiftwidth = 0 -- Spaces to use for autoindent. 0 uses tabstop value
o.showbreak = "↪" -- Indicator at the start of wrapped lines
o.showmatch = true -- Highlight matching brackets as you type
o.sidescrolloff = 3 -- Min cols to keep on screen
o.softtabstop = -1 -- If negative shiftwidth value is used
o.swapfile = false -- How often does vim crash anyway?
o.tabstop = 4 -- Spaces a tab is worth
o.timeoutlen = 500 -- MS to wait for mapping to complete
-- o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Save undo history
o.wildignorecase = true -- Case insensitive completion

g.mapleader = " "
g.maplocalleader = " "
g.t_co = 256

-- g.nvim_markdown_preview_format = "markdown"

g.netrw_sort_by = "time"
g.netrw_liststyle = 1
g.netrw_sort_direction = "reverse"

g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0
g.neovide_floating_shadow = true
g.neovide_floating_z_height = 10
g.neovide_light_angle_degrees = 45
g.neovide_light_radius = 5
g.neovide_hide_mouse_when_typing = true

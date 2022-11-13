local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.t_co = 256
g.background = "dark"

-- Netrw plugin options
-- g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
-- g.netrw_altv = 1
g.netrw_winsize = 25

--" Emmet
g.user_emmet_mode = 'a' --" enable all function in all mode.
g.user_emmet_install_global = 1 --" enable just for html/css
g.user_emmet_leader_key = ','

--" Prettier
g['prettier#autoformat'] = 1
g['prettier#autoformat_require_pragma'] = 0
g['prettier#config#use_tabs'] = false
g['prettier#quickfix_auto_focus'] = 0

o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.lazyredraw= true -- Don't redraw screen while executing macros
o.spell= true -- Spellcheck by default
o.dictionary="/usr/share/dict/words"
-- Time out on key codes but not mappings.
-- Basically this makes terminal Vim work sanely.
o.timeout = false
o.swapfile = false-- How often does vim crash anyway?
o.hidden = true      -- Allow unsaved buffers in background
-- New vsplit will be to right of current one
o.splitbelow = true
o.splitright = true
--o.path+=** -- Allows for fuzzy-like :find-ing
-- Expand as much as possible, then show the list
o.wildmode="list:longest,full"
-- Case insensitive completion
o.wildignorecase = true
--[[
o.wildignore+=*.tags,tags                    -- ignore tags files
o.wildignore+=..git                          -- Version control
o.wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg -- binary images
o.wildignore+=*.sw?,.bak                     -- Vim swap files
--]]
o.scrolloff=3
o.sidescrolloff=3
o.showbreak="↪" -- Indicator at the start of wrapped lines
o.cursorline = true  -- Highlight current line
o.number = true
o.relativenumber = true -- Current line actual line number, other relative to cursor
-- Wrap long lines, but not in the middle of a word, and maintain indent level
o.wrap = true
o.linebreak = true
o.breakindent = true
-- Case insensitive searching, unless search includes uppercase letters, including during insert completion
o.ignorecase = true
o.smartcase = true
o.infercase = true
-- Highlight matching brackets as you type
o.showmatch = true
o.cindent = true
-- Makes neovim and host OS clipboard play nicely with each other
-- o.clipboard = 'unnamedplus'
-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
o.confirm = true



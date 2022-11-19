--[[
set fdm=expr fde=getline(v\:lnum)=~'^\\s*$'&&getline(v\:lnum+1)=~'\\S'?'<1'\:1
]]
local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.t_co = 256

-- Netrw plugin options
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_winsize = 25
-- g.netrw_banner = 0
-- g.netrw_altv = 1

-- Emmet
g.user_emmet_mode = 'a' --" enable all function in all mode.
g.user_emmet_install_global = 1 --" enable just for html/css
g.user_emmet_leader_key = ','

-- Prettier
g['prettier#autoformat'] = 1
g['prettier#autoformat_require_pragma'] = 0
g['prettier#config#use_tabs'] = false
g['prettier#quickfix_auto_focus'] = 0

-- Spaces and tabs
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.cindent = true

-- Spellcheck
o.spell =  true -- Spellcheck by default
o.dictionary = "/usr/share/dict/words"

-- Wildmode ie completion
o.wildmode = "list:longest,full" -- Expand as much as possible, then show the list
o.wildignorecase = true -- Case insensitive completion

-- Cursors and scrolling
o.cursorline = true  -- Highlight current line
o.scrolloff = 3
o.sidescrolloff = 3

o.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\\\*\\\\\\|\\\\*/\\\\\\|{{{\\\\d\\\\=','','g')"

-- Line numbers
o.number = true
o.relativenumber = true -- Current line actual line number, other relative to cursor

-- Wrapping
o.wrap = true -- Wrap long lines, but not in the middle of a word, and maintain indent level
o.linebreak = true
o.breakindent = true
o.showbreak = "↪" -- Indicator at the start of wrapped lines

-- Searching
o.ignorecase = true -- Case insensitive searching...
o.smartcase = true -- ...unless search includes uppercase letters...
o.infercase = true -- ...including during insert completion
o.showmatch = true -- Highlight matching brackets as you type

-- Windows
o.splitbelow = true
o.splitright = true

-- Misc
o.keywordprg = ':help' -- 'K' searches vim docs
o.lazyredraw = true -- Don't redraw screen while executing macros
o.timeout = false -- Time out on key codes but not mappings. Basically this makes terminal Vim work sanely.
o.swapfile = false-- How often does vim crash anyway?
--o.path+=** -- Allows for fuzzy-like :find-ing
-- o.clipboard = 'unnamedplus' Makes neovim and host OS clipboard play nicely with each other
-- After using it, I prefer the mappings I have set up to <leader>y/p
o.confirm = true -- Instead of failing a command because of unsaved changes, raise a dialogue asking if you wish to save changed files.


--[[
o.wildignore+=*.tags,tags                    -- ignore tags files
o.wildignore+=..git                          -- Version control
o.wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg -- binary images
o.wildignore+=*.sw?,.bak                     -- Vim swap files
--]]

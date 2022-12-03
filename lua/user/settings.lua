for key, value in pairs({ -- NeoVim settings
	breakindent = true,
	cindent = true,
	confirm = true, -- Instead of failing a command because of unsaved changes, raise a dialogue asking if you wish to save changed files.
	cursorline = true, -- Highlight current line
	dictionary = "/usr/share/dict/words",
	ignorecase = true, -- Case insensitive searching...
	infercase = true, -- ...including during insert completion
	keywordprg = ':help', -- 'K' searches vim docs
	lazyredraw = true, -- Don't redraw screen while executing macros
	linebreak = true,
	number = true,
	-- o.clipboard = 'unnamedplus',-- Makes neovim and host OS clipboard play nicely with each other
	relativenumber = true, -- Current line actual line number, other relative to cursor
	scrolloff = 3,
	sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	shiftwidth = 0,
	showbreak = "↪", -- Indicator at the start of wrapped lines
	showmatch = true, -- Highlight matching brackets as you type
	sidescrolloff = 3,
	smartcase = true, -- ...unless search includes uppercase letters...
	softtabstop = -1, -- If negative, shiftwidth value is used
	spell = true, -- Spellcheck by default
	splitbelow = true,
	splitright = true,
	swapfile = false, -- How often does vim crash anyway?
	tabstop = 4,
	timeout = false, -- Time out on key codes but not mappings. Basically this makes terminal Vim work sanely.
	wildignorecase = true, -- Case insensitive completion
	wildmode = "list:longest,full", -- Expand as much as possible, then show the list
	wrap = true, -- Wrap long lines, but not in the middle of a word, and maintain indent level
}) do vim.opt[key] = value end

for key, value in pairs({ -- globals (for older plugins)
	mapleader = ' ',
	maplocalleader = ' ',
	t_co = 256,

	-- Netrw plugin options
	netrw_liststyle = 3,
	netrw_browse_split = 4,
	netrw_winsize = 25,
	-- netrw_banner = 0,
	-- netrw_altv = 1,
}) do vim.g[key] = value end
-- vim: foldlevel=1

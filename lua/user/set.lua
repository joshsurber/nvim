for key, value in pairs({ -- NeoVim settings

    -- backup = false, -- Don't need backups with infinite undo
    -- cursorline = true, -- Highlight current line
    -- ignorecase = true, -- Case insensitive searching...
    -- infercase = true, -- ...including during insert completion
    -- linebreak = true, -- Break lines at `breakat` chars instead of last col
    -- number = true, -- Show line numbers (with relnumber, make current line no absolute)
    -- smartcase = true, -- ...unless search includes uppercase letters...
    -- splitbelow = true, splitright = true, -- New windows below and to right
    -- termguicolors = true, -- Enable colors in the terminal
    -- undofile = true, -- Save undo history
    -- wrap = true, -- Wrap long lines, but not in the middle of a word, and maintain indent level
    breakindent = true, -- Indent lines when wrapping text
    cindent = true, -- Indent using C-style rules
    confirm = true, -- Instead of failing a command because of unsaved changes, raise a dialogue asking if you wish to save changed files.
    dictionary = "/usr/share/dict/words",
    expandtab = true, -- Use spaces instead of tabs
    guifont='Cascadia Code PL,Symbols Nerd Font:h10', -- For Neovide etc
    keywordprg = ':help', -- 'K' searches vim docs
    lazyredraw = true, -- Don't redraw screen while executing macros
    -- relativenumber = true, -- Current line actual line number, other relative to cursor
    scrolloff = 3, -- Lines to keep on screen
    shiftwidth = 0, -- Spaces to use for autoindent. 0 uses tabstop value
    showbreak = "↪", -- Indicator at the start of wrapped lines
    showmatch = true, -- Highlight matching brackets as you type
    sidescrolloff = 3, -- Min cols to keep on screen
    softtabstop = -1, -- If negative, shiftwidth value is used
    spell = true, -- Spellcheck by default
    swapfile = false, -- How often does vim crash anyway?
    tabstop = 4, -- Spaces a tab is worth
    timeoutlen = 500, -- MS to wait for mapping to complete
    undodir = os.getenv("HOME") .. "/.vim/undodir", -- Save undo history
    wildignorecase = true, -- Case insensitive completion

}) do vim.opt[key] = value end

for key, value in pairs({ -- globals (for older plugins)

    mapleader = ' ',
    maplocalleader = ' ',
    t_co = 256,

    -- Netrw plugin options
    netrw_liststyle = 3,
    netrw_browse_split = 4,
    netrw_winsize = 25,
    netrw_banner = 0,
    -- netrw_altv = 1,

    nvim_markdown_preview_format = 'markdown',

}) do vim.g[key] = value end
-- vim: foldlevel=1

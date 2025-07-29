for key, value in pairs({ -- NeoVim settings

    cindent = true, -- Indent using C-style rules
    confirm = true, -- Instead of failing a command because of unsaved changes, raise a dialogue asking if you wish to save changed files.
    dictionary = "/usr/share/dict/words",
    expandtab = true, -- Use spaces instead of tabs
    -- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
    foldcolumn = "auto",
    foldlevel = 99,
    foldlevelstart = 1,
    foldnestmax = 3,
    foldtext = "",
    guifont = "Cascadia Code NF:h9", -- For Neovide etc
    -- guifont = "CaskaydiaCove NF:h9", -- For Neovide etc
    keywordprg = ":help", -- 'K' searches vim docs
    lazyredraw = true, -- Don't redraw screen while executing macros
    relativenumber = true,
    scrolloff = 3, -- Lines to keep on screen
    shiftwidth = 0, -- Spaces to use for autoindent. 0 uses tabstop value
    showbreak = "↪", -- Indicator at the start of wrapped lines
    showmatch = true, -- Highlight matching brackets as you type
    sidescrolloff = 3, -- Min cols to keep on screen
    softtabstop = -1, -- If negative, shiftwidth value is used
    swapfile = false, -- How often does vim crash anyway?
    tabstop = 4, -- Spaces a tab is worth
    timeoutlen = 500, -- MS to wait for mapping to complete
    undodir = os.getenv("HOME") .. "/.vim/undodir", -- Save undo history
    wildignorecase = true, -- Case insensitive completion
}) do
    vim.opt[key] = value
end

-- -- Helper function for transparency formatting
-- local alpha = function()
--   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
-- end
-- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 0.8
-- vim.g.transparency = 0.8
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

for key, value in pairs({ -- globals (for older plugins)

    mapleader = " ",
    maplocalleader = " ",
    t_co = 256,

    nvim_markdown_preview_format = "markdown",
    netrw_sort_by = "time",
    netrw_liststyle = 1,
    netrw_sort_direction = "reverse",

    neovide_floating_blur_amount_x = 2.0,
    neovide_floating_blur_amount_y = 2.0,

    neovide_floating_shadow = true,
    neovide_floating_z_height = 10,
    neovide_light_angle_degrees = 45,
    neovide_light_radius = 5,

    neovide_hide_mouse_when_typing = true,
}) do
    vim.g[key] = value
end

return {
    --[[ PLUGIN DEPENDANCIES]]
    'nvim-tree/nvim-web-devicons', -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-lua/plenary.nvim', -- https://github.com/nvim-lua/plenary.nvim

    --[[ COLOR SCHEMES ]]
    { 'ellisonleao/gruvbox.nvim', lazy = true }, -- https://github.com/ellisonleao/gruvbox.nvim
    { 'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000
    }, -- https://github.com/folke/tokyonight.nvim
    { 'ishan9299/nvim-solarized-lua', lazy = true },
    { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
    { 'ray-x/starry.nvim', lazy = true }, -- https://github.com/ray-x/starry.nvim

    --[[ NEOVIM SETTINGS ]]
    'echasnovski/mini.nvim', -- Small utilities -- https://github.com/echasnovski/mini.nvim
    'folke/which-key.nvim', -- Popup tree of available key mappings
    'akinsho/toggleterm.nvim', -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
    'mbbill/undotree', -- https://github.com/mbbill/undotree
    'nvim-telescope/telescope.nvim', -- Fuzzy file finder -- https://github.com/nvim-telescope/telescope.nvim
    'tpope/vim-eunuch', -- Unix utilities -- https://github.com/tpope/vim-eunuch
    'tpope/vim-repeat', -- Do it again -- https://github.com/tpope/vim-repeat
    'vifm/vifm.vim',

    --[[ GIT INTEGRATION ]]
    'tpope/vim-fugitive', -- Git integration -- https://github.com/tpope/vim-fugitive
    'lewis6991/gitsigns.nvim', -- Track git changes in gutter -- https://github.com/lewis6991/gitsigns.nvim

    --[[ CODING ]]
    'davidgranstrom/nvim-markdown-preview', -- https://github.com/davidgranstrom/nvim-markdown-preview
    -- 'hail2u/vim-css3-syntax', -- The newest hawtness of CSS -- https://github.com/hail2u/vim-css3-syntax
    -- 'mattn/emmet-vim', -- https://github.com/mattn/emmet-vim
    'tpope/vim-liquid', -- Support for liquid templates -- https://github.com/tpope/vim-liquid
    'windwp/nvim-ts-autotag', -- Auto close tags and rename in pairs -- https://github.com/windwp/nvim-ts-autotag

    --[[ TREESITTER STUFF ]]
    -- 'nvim-treesitter/nvim-treesitter-context', -- Where am I in my code -- https://github.com/nvim-treesitter/nvim-treesitter-context
    -- 'nvim-treesitter/playground', -- https://github.com/nvim-treesitter/playground
    'mrjones2014/nvim-ts-rainbow', -- Rainbow parentheses
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', }, -- Language awareness -- https://github.com/nvim-treesitter/nvim-treesitter


    --[[ EXPERIMENTAL]]
    -- Plugins I want to try go here
    --[[ /EXPERIMENTAL]]


}
-- vim: foldlevel=1

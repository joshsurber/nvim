local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Makes it easier to copy/paste from GH readmes

    --[[ PLUGIN DEPENDANCIES]]
    'wbthomason/packer.nvim', -- You are here -- https://github.com/wbthomason/packer.nvim
    'nvim-tree/nvim-web-devicons', -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-lua/plenary.nvim', -- https://github.com/nvim-lua/plenary.nvim

    --[[ COLOR SCHEMES ]]
    'ellisonleao/gruvbox.nvim', -- https://github.com/ellisonleao/gruvbox.nvim
    'folke/tokyonight.nvim', -- https://github.com/folke/tokyonight.nvim
    'ishan9299/nvim-solarized-lua',
    { 'rose-pine/neovim', name = 'rose-pine', },
    'ray-x/starry.nvim', -- https://github.com/ray-x/starry.nvim

    --[[ NEOVIM SETTINGS ]]
    'echasnovski/mini.nvim', -- Small utilities -- https://github.com/echasnovski/mini.nvim
    'folke/which-key.nvim', -- Popup tree of available key mappings
    'akinsho/toggleterm.nvim', -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
    'mbbill/undotree', -- https://github.com/mbbill/undotree
    'nvim-telescope/telescope.nvim', -- Fuzzy file finder -- https://github.com/nvim-telescope/telescope.nvim
    'tpope/vim-eunuch', -- Unix utilities -- https://github.com/tpope/vim-eunuch
    'tpope/vim-repeat', -- Do it again -- https://github.com/tpope/vim-repeat

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

    --[[ LSP STUFF ]]
    -- LSP Support
    'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
    'williamboman/mason.nvim', -- https://github.com/williamboman/mason.nvim
    'williamboman/mason-lspconfig.nvim', -- https://github.com/williamboman/mason-lspconfig.nvim
    -- Autocompletion
    'hrsh7th/nvim-cmp', -- https://github.com/hrsh7th/nvim-cmp
    'hrsh7th/cmp-buffer', -- https://github.com/hrsh7th/cmp-buffer
    'hrsh7th/cmp-path', -- https://github.com/hrsh7th/cmp-path
    'saadparwaiz1/cmp_luasnip', -- https://github.com/saadparwaiz1/cmp_luasnip
    'hrsh7th/cmp-nvim-lsp', -- https://github.com/hrsh7th/cmp-nvim-lsp
    'hrsh7th/cmp-nvim-lua', -- https://github.com/hrsh7th/cmp-nvim-lua
    -- Snippets
    'L3MON4D3/LuaSnip', -- https://github.com/L3MON4D3/LuaSnip
    'rafamadriz/friendly-snippets', -- https://github.com/rafamadriz/friendly-snippets
    -- Configure LSP
    'VonHeikemen/lsp-zero.nvim', -- Simple LSP setup -- https://github.com/VonHeikemen/lsp-zero.nvim
    'jose-elias-alvarez/null-ls.nvim', -- Inject 3rd party executables into LSP -- https://github.com/jose-elias-alvarez/null-ls.nvim

    --[[ EXPERIMENTAL]]
    -- Plugins I want to try go here
    --[[ /EXPERIMENTAL]]


})

-- vim: foldlevel=1

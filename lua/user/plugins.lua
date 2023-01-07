local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
" autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

return require('packer').startup(function(use)
    -- Makes it easier to copy/paste from GH readmes
    local function Plug(plugin)
        return use(plugin)
    end

    --[[ PLUGIN DEPENDANCIES]]
    use 'wbthomason/packer.nvim' -- You are here -- https://github.com/wbthomason/packer.nvim
    -- use 'nvim-tree/nvim-web-devicons' -- https://github.com/nvim-tree/nvim-web-devicons
    use 'nvim-lua/plenary.nvim' -- https://github.com/nvim-lua/plenary.nvim

    --[[ COLOR SCHEMES ]]
    use 'folke/tokyonight.nvim' -- https://github.com/folke/tokyonight.nvim
    -- use 'ellisonleao/gruvbox.nvim' -- https://github.com/ellisonleao/gruvbox.nvim
    -- use 'ray-x/starry.nvim' -- https://github.com/ray-x/starry.nvim
    -- use 'tanvirtin/monokai.nvim' -- https://github.com/tanvirtin/monokai.nvim
    -- use 'Mofiqul/dracula.nvim' -- https://github.com/Mofiqul/dracula.nvim

    --[[ NEOVIM SETTINGS ]]
    use "folke/which-key.nvim" -- Popup tree of available key mappings
    use 'akinsho/bufferline.nvim' -- tabs for open buffers -- https://github.com/akinsho/bufferline.nvim
    use 'akinsho/toggleterm.nvim' -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
    use 'moll/vim-bbye' -- Close buffer without exit -- https://github.com/moll/vim-bbye
    use 'nvim-lualine/lualine.nvim' -- Statusline -- https://github.com/nvim-lualine/lualine.nvim
    use 'nvim-telescope/telescope.nvim' -- Fuzzy file finder -- https://github.com/nvim-telescope/telescope.nvim
    use 'rmagatti/auto-session' -- Save and restore sessions automatically -- https://github.com/rmagatti/auto-session
    use 'tpope/vim-eunuch' -- Unix utilities -- https://github.com/tpope/vim-eunuch
    use 'tpope/vim-repeat' -- Do it again -- https://github.com/tpope/vim-repeat
    -- use 'tpope/vim-sleuth' -- Automagically determine tabwidth etc -- https://github.com/tpope/vim-sleuth
    -- use 'tpope/vim-vinegar' -- Make Netrw suck less -- https://github.com/tpope/vim-vinegar
    use 'mbbill/undotree' -- https://github.com/mbbill/undotree

    --[[ GIT INTEGRATION ]]
    use 'tpope/vim-fugitive' -- Git integration -- https://github.com/tpope/vim-fugitive
    use 'lewis6991/gitsigns.nvim' -- Track git changes in gutter -- https://github.com/lewis6991/gitsigns.nvim

    --[[ GENERAL CODING ]]
    use 'numToStr/Comment.nvim' -- Comment and uncomment lines -- https://github.com/numToStr/Comment.nvim
    use 'kylechui/nvim-surround' -- Suround things -- https://github.com/kylechui/nvim-surround
    -- use 'lukas-reineke/indent-blankline.nvim' -- Track indents -- https://github.com/lukas-reineke/indent-blankline.nvim

    --[[ WEB DEVELOPMENT SPECIFIC ]]
    use 'tpope/vim-liquid' -- Support for liquid templates -- https://github.com/tpope/vim-liquid
    -- use 'hail2u/vim-css3-syntax' -- The newest hawtness of CSS -- https://github.com/hail2u/vim-css3-syntax
    use 'windwp/nvim-ts-autotag' -- Auto close tags and rename in pairs -- https://github.com/windwp/nvim-ts-autotag
    use 'windwp/nvim-autopairs' -- Match brackets -- https://github.com/windwp/nvim-autopairs
    -- use 'davidgranstrom/nvim-markdown-preview' -- https://github.com/davidgranstrom/nvim-markdown-preview
    -- use 'mattn/emmet-vim' -- https://github.com/mattn/emmet-vim

    --[[ TREESITTER STUFF ]]
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', } -- Language awareness -- https://github.com/nvim-treesitter/nvim-treesitter
    -- use 'nvim-treesitter/nvim-treesitter-context' -- Where am I in my code -- https://github.com/nvim-treesitter/nvim-treesitter-context
    -- use 'nvim-treesitter/playground' -- https://github.com/nvim-treesitter/playground
    -- use "p00f/nvim-ts-rainbow" -- Rainbow parentheses

    --[[ TEXT OBJECCTS ]]
    -- use 'wellle/targets.vim' -- improve text objects -- https://github.com/wellle/targets.vim
    -- use 'nvim-treesitter/nvim-treesitter-textobjects' -- Adds function and clss objs -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- use 'RRethy/nvim-treesitter-textsubjects' -- https://github.com/RRethy/nvim-treesitter-textsubjects
    use 'chrisgrieser/nvim-various-textobjs' -- https://github.com/chrisgrieser/nvim-various-textobjs

    --[[ LSP STUFF ]]
    -- LSP Support
    use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
    use 'williamboman/mason.nvim' -- https://github.com/williamboman/mason.nvim
    use 'williamboman/mason-lspconfig.nvim' -- https://github.com/williamboman/mason-lspconfig.nvim
    -- Autocompletion
    use 'hrsh7th/nvim-cmp' -- https://github.com/hrsh7th/nvim-cmp
    use 'hrsh7th/cmp-buffer' -- https://github.com/hrsh7th/cmp-buffer
    use 'hrsh7th/cmp-path' -- https://github.com/hrsh7th/cmp-path
    use 'saadparwaiz1/cmp_luasnip' -- https://github.com/saadparwaiz1/cmp_luasnip
    use 'hrsh7th/cmp-nvim-lsp' -- https://github.com/hrsh7th/cmp-nvim-lsp
    use 'hrsh7th/cmp-nvim-lua' -- https://github.com/hrsh7th/cmp-nvim-lua
    -- Snippets
    use 'L3MON4D3/LuaSnip' -- https://github.com/L3MON4D3/LuaSnip
    use 'rafamadriz/friendly-snippets' -- https://github.com/rafamadriz/friendly-snippets
    -- Configure LSP
    use 'VonHeikemen/lsp-zero.nvim' -- Simple LSP setup -- https://github.com/VonHeikemen/lsp-zero.nvim
    use 'jose-elias-alvarez/null-ls.nvim' -- Inject 3rd party executables into LSP -- https://github.com/jose-elias-alvarez/null-ls.nvim

    --[[ EXPERIMENTAL]]
    -- Plugins I want to try go here

    --[[ /EXPERIMENTAL]]

    if packer_bootstrap then -- // Automatically set up your configuration after cloning packer.nvim
        require('packer').sync()
    end

    -- For plugins that require more than a `use` but not a full file
    for _, plugin in pairs({
        'nvim-autopairs',
        'nvim-surround',
        'Comment',
    }) do
        local ok, result = pcall(require, plugin)
        if not ok then return vim.notify(plugin .. ' not loaded') end
        pcall(result.setup)
        -- vim.notify(plugin .. ' loaded')
    end

end)

-- vim: foldlevel=1

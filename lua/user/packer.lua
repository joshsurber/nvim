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
autocmd BufWritePost packer.lua source <afile> | PackerCompile
" autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]])

return require('packer').startup(function(use)
    -- Makes it easier to copy/paste from GH readmes
    local function Plug(plugin)
        return use(plugin)
    end

    --[[ PLUGIN DEPENDANCIES]]
    use 'wbthomason/packer.nvim' -- You are here -- https://github.com/wbthomason/packer.nvim
    use 'nvim-tree/nvim-web-devicons' -- https://github.com/nvim-tree/nvim-web-devicons
    use 'nvim-lua/plenary.nvim' -- https://github.com/nvim-lua/plenary.nvim

    --[[ COLOR SCHEMES ]]
    use 'ellisonleao/gruvbox.nvim' -- https://github.com/ellisonleao/gruvbox.nvim
    use 'folke/tokyonight.nvim' -- https://github.com/folke/tokyonight.nvim
    use 'ray-x/starry.nvim' -- https://github.com/ray-x/starry.nvim

    --[[ NEOVIM SETTINGS ]]
    use 'echasnovski/mini.nvim' -- Small utilities -- https://github.com/echasnovski/mini.nvim
    use "folke/which-key.nvim" -- Popup tree of available key mappings
    use 'akinsho/toggleterm.nvim' -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
    use 'mbbill/undotree' -- https://github.com/mbbill/undotree
    use 'nvim-telescope/telescope.nvim' -- Fuzzy file finder -- https://github.com/nvim-telescope/telescope.nvim
    use 'tpope/vim-eunuch' -- Unix utilities -- https://github.com/tpope/vim-eunuch
    use 'tpope/vim-repeat' -- Do it again -- https://github.com/tpope/vim-repeat

    --[[ GIT INTEGRATION ]]
    use 'tpope/vim-fugitive' -- Git integration -- https://github.com/tpope/vim-fugitive
    use 'lewis6991/gitsigns.nvim' -- Track git changes in gutter -- https://github.com/lewis6991/gitsigns.nvim

    --[[ CODING ]]
    use 'davidgranstrom/nvim-markdown-preview' -- https://github.com/davidgranstrom/nvim-markdown-preview
    -- use 'hail2u/vim-css3-syntax' -- The newest hawtness of CSS -- https://github.com/hail2u/vim-css3-syntax
    -- use 'mattn/emmet-vim' -- https://github.com/mattn/emmet-vim
    use 'tpope/vim-liquid' -- Support for liquid templates -- https://github.com/tpope/vim-liquid
    use 'windwp/nvim-ts-autotag' -- Auto close tags and rename in pairs -- https://github.com/windwp/nvim-ts-autotag

    --[[ TREESITTER STUFF ]]
    -- use 'nvim-treesitter/nvim-treesitter-context' -- Where am I in my code -- https://github.com/nvim-treesitter/nvim-treesitter-context
    -- use 'nvim-treesitter/playground' -- https://github.com/nvim-treesitter/playground
    use "mrjones2014/nvim-ts-rainbow" -- Rainbow parentheses
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', } -- Language awareness -- https://github.com/nvim-treesitter/nvim-treesitter

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
        'which-key',
        -- 'nvim-autopairs',
        -- 'nvim-surround',
        -- 'Comment',
    }) do
        local ok, result = pcall(require, plugin)
        if not ok then return vim.notify(plugin .. ' not loaded') end
        pcall(result.setup)
        -- vim.notify(plugin .. ' loaded')
    end

end)

-- vim: foldlevel=1

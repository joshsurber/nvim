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
"autocmd BufWritePost plugins.lua source <afile> | PackerCompile
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])
return require('packer').startup(function(use)
	local function Plug(plugin)
		return use(plugin)
	end

	--[[ plugin dependancies]]
	use 'wbthomason/packer.nvim' -- You are here
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'

	--[[ neovim settings ]]
	use 'moll/vim-bbye' -- Close buffer without exit
	-- use 'tpope/vim-obsession' -- Easy session management
	use 'tpope/vim-repeat' -- Do it again
	-- use 'tpope/vim-vinegar' -- Make Netrw suck less
	-- use 'wellle/targets.vim' -- improve text objects
	-- use 'tpope/vim-sleuth' -- Automagically determine tabwidth etc
	use 'karb94/neoscroll.nvim' -- Smooth scrolling
	use 'ellisonleao/gruvbox.nvim'
	use 'akinsho/toggleterm.nvim' -- Easy terminal access
	use 'nvim-lualine/lualine.nvim' -- Statusline
	use 'rmagatti/auto-session'
	use "folke/which-key.nvim"

	--[[ SYSTEM INTEGRATION ]]
	use 'tpope/vim-eunuch' -- Unix utilities
	use 'nvim-telescope/telescope.nvim' -- Fuzzy file finder
	use 'akinsho/bufferline.nvim'

	--[[ GIT INTEGRATION ]]
	use 'tpope/vim-fugitive' -- Git integration
	use 'lewis6991/gitsigns.nvim' -- Track git changes in gutter

	--[[ GENERAL CODING ]]
	use 'numToStr/Comment.nvim' -- Comment and uncomment lines
	use 'kylechui/nvim-surround' -- Suround things
	use 'lukas-reineke/indent-blankline.nvim' -- Track indents

	--[[ WEB DEVELOPMENT SPECIFIC ]]
	use 'tpope/vim-liquid' -- Support for liquid templates
	use 'hail2u/vim-css3-syntax' -- The newest hawtness of CSS
	use 'windwp/nvim-ts-autotag' -- Auto close tags and rename in pairs
	use 'windwp/nvim-autopairs' -- Match brackets
	use 'davidgranstrom/nvim-markdown-preview'

	--[[ TREESITTER STUFF ]]
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', } -- Language awareness
	use 'nvim-treesitter/nvim-treesitter-context' -- Where am I in my code
	use 'nvim-treesitter/nvim-treesitter-textobjects' -- Adds function and clss objs
	-- use 'nvim-treesitter/playground'
	use "p00f/nvim-ts-rainbow" -- Rainbow parentheses

	--[[ LSP STUFF ]]
	-- LSP Support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	-- Autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'

	use 'VonHeikemen/lsp-zero.nvim' -- Simple LSP setup
	use 'jose-elias-alvarez/null-ls.nvim' -- Inject 3rd party executables into LSP

	if packer_bootstrap then -- // Automatically set up your configuration after cloning packer.nvim
		require('packer').sync()
	end
end)
-- vim: foldlevel=1

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
"autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])


return require('packer').startup(function(use)

	--[[ plugin dependancies]]
	use 'wbthomason/packer.nvim' -- You are here
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'

	--[[ neovim settings ]]
	use 'moll/vim-bbye' -- Close buffer without exit
	use 'tpope/vim-obsession' -- Easy session management
	use 'tpope/vim-repeat' -- Do it again
	use 'tpope/vim-vinegar' -- Make Netrw suck less
	use 'wellle/targets.vim' -- improve text objects
	use 'tpope/vim-sleuth' -- Automagically determine tabwidth etc
	use { 'karb94/neoscroll.nvim',
		config = function()
			require('neoscroll').setup()
		end
	}
	use { 'ellisonleao/gruvbox.nvim',
		config = function()
			vim.cmd [[ colorscheme gruvbox]]
		end
	}
	use { 'akinsho/toggleterm.nvim', -- Easy terminal access
		tag = '*',
		config = function()
			require("toggleterm").setup({
				open_mapping = '<C-g>',
				direction = 'horizontal',
				shade_terminals = true
			})
		end
	}
	use { 'nvim-lualine/lualine.nvim', -- Statusline
		config = function()
			require('lualine').setup({
				theme = 'gruvbox',
				icons_enabled = true,
				sections = { lualine_c = { "%{ObsessionStatus()}" } }
			})
		end
	}

	--[[ SYSTEM INTEGRATION ]]
	use 'tpope/vim-eunuch' -- Unix utilities
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', } -- Fuzzy file finder
	use 'akinsho/bufferline.nvim'


	--[[ GIT INTEGRATION ]]
	use 'tpope/vim-fugitive' -- Git integration
	use 'lewis6991/gitsigns.nvim' -- Track git changes in gutter

	--[[ GENERAL CODING ]]
	use { 'numToStr/Comment.nvim', -- Comment and uncomment lines
		config = function()
			require('Comment').setup()
		end
	}
	use { 'kylechui/nvim-surround', -- Suround things
		config = function()
			require("nvim-surround").setup()
		end
	}
	use { 'lukas-reineke/indent-blankline.nvim', -- Track indents
		config = function()
			require('indent_blankline').setup({
				char = '▏',
				show_trailing_blankline_indent = false,
				show_first_indent_level = false,
				use_treesitter = true,
				show_current_context = false
			})
		end
	}

	--[[ WEB DEVELOPMENT SPECIFIC ]]
	use 'tpope/vim-liquid' -- Support for liquid templates
	use 'hail2u/vim-css3-syntax' -- The newest hawtness of CSS
	use 'uga-rosa/ccc.nvim'
	use { 'windwp/nvim-ts-autotag', -- Auto close tags and rename in pairs
		-- disable = true,
		config = function()
			require('nvim-ts-autotag').setup()
		end
	}
	use { 'windwp/nvim-autopairs', -- Match brackets
		config = function()
			require("nvim-autopairs").setup()
		end
	}
	use { 'norcalli/nvim-colorizer.lua', -- Highlight colors in a file
		disable = true,
		config = function()
			require 'colorizer'.setup()
		end
	}

	--[[ TREESITTER STUFF ]]
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', } -- Language awareness
	use 'nvim-treesitter/nvim-treesitter-context' -- Where am I in my code
	use "p00f/nvim-ts-rainbow" -- Rainbox parentheses

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

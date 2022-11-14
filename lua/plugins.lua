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
	-- use 'tpope/vim-sensible'
	-- use 'tpope/vim-sleuth'
	-- use 'alvan/vim-closetag'
	-- use 'flazz/vim-colorschemes' -- pretty much all vim colorschemes
	-- use 'junegunn/vim-peekaboo'            --" Show registers when summoned

	use 'wbthomason/packer.nvim' -- You are here
	use 'tpope/vim-eunuch' -- Unix utilities
	use 'tpope/vim-fugitive' -- Git integration
	use 'tpope/vim-obsession' -- Easy session management
	use 'tpope/vim-repeat' -- Do it again
	use 'tpope/vim-vinegar' -- Make Netrw suck less
	use 'tpope/vim-liquid' -- Support for liquid templates
	use 'wellle/targets.vim' -- improve text objects
	use 'ap/vim-css-color' --" View colors in CSS
	use 'ellisonleao/gruvbox.nvim' -- Nice, dark theme
	use 'hail2u/vim-css3-syntax' -- The newest hawtness of CSS
	use 'mattn/emmet-vim' -- Emmet
	use 'nvim-treesitter/nvim-treesitter-context' -- Where am I in my code
	use "p00f/nvim-ts-rainbow" -- Rainbox parentheses
	use { 'norcalli/nvim-colorizer.lua', -- Highlight colors in a file
		config = function()
			require 'colorizer'.setup()
		end
	}
	use { 'MunifTanjim/prettier.nvim', -- Format code
		-- use 'prettier/vim-prettier', { 'do': 'yarn install' }
		requires = {
			'neovim/nvim-lspconfig',
			'jose-elias-alvarez/null-ls.nvim'
		},
		config = function()
			local null_ls = require("null-ls")
			local prettier = require("prettier")

			prettier.setup({
				bin = 'prettier', -- or `'prettierd'` (v0.22+)
				filetypes = {
					"css",
					"graphql",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"less",
					"markdown",
					"scss",
					"typescript",
					"typescriptreact",
					"yaml",
				},
			})
			null_ls.setup({
				on_attach = function(client, bufnr)
					if client.server_capabilities.documentFormattingProvider then
						print('supports')
						vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

						-- format on save
						vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
						vim.api.nvim_create_autocmd('BufWritePost', {
							callback = function()
								vim.lsp.buf.formatting()
							end
						})
					else
						print('doesnt support')
						vim.api.nvim_create_autocmd('BufWritePost', {
							callback = function()
								vim.lsp.buf.formatting()
							end
						})
					end

					if client.server_capabilities.documentRangeFormattingProvider then
						vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
					end
				end,
			})
		end
	}
	use { 'kylechui/nvim-surround', -- Suround things
		-- use 'tpope/vim-surround' REPLACED
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	}
	use { 'windwp/nvim-ts-autotag', -- Auto close tags and rename in pairs
		-- use 'AndrewRadev/tagalong.vim' -- REPLACED
		-- disable = true,
		config = function()
			require('nvim-ts-autotag').setup()
		end
	}
	use { 'windwp/nvim-autopairs', -- Match brackets
		config = function()
			require("nvim-autopairs").setup({

			})
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
	use { 'numToStr/Comment.nvim', -- Comment and uncomment lines
		-- use 'tpope/vim-commentary' -- REPLACED
		config = function()
			require('Comment').setup()
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
	use { 'nvim-lualine/lualine.nvim', -- Statusline
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup({
				theme = 'gruvbox',
				icons_enabled = true,
			})
		end
	}
	use { 'nvim-telescope/telescope.nvim', -- Fuzzy file finder
		tag = '0.1.0',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end
	}
	use { 'lewis6991/gitsigns.nvim', -- Track git changes in gutter
		-- use 'airblade/vim-gitgutter' -- REPLACED
		disable = true,
		config = function()
			require('gitsigns').setup {
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map('n', ']c', function()
						if vim.wo.diff then return ']c' end
						vim.schedule(function() gs.next_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					map('n', '[c', function()
						if vim.wo.diff then return '[c' end
						vim.schedule(function() gs.prev_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					-- Actions
					map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
					map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
					map('n', '<leader>hS', gs.stage_buffer)
					map('n', '<leader>hu', gs.undo_stage_hunk)
					map('n', '<leader>hR', gs.reset_buffer)
					map('n', '<leader>hp', gs.preview_hunk)
					map('n', '<leader>hb', function() gs.blame_line { full = true } end)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
					map('n', '<leader>hd', gs.diffthis)
					map('n', '<leader>hD', function() gs.diffthis('~') end)
					map('n', '<leader>td', gs.toggle_deleted)

					-- Text object
					map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
				end
			}
		end
	}
	use { 'nvim-treesitter/nvim-treesitter', -- Language awareness
		run = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				auto_install = true,
				highlight = { enable = true },
				-- incremental_selection = { enable = true },
				textobjects = { enable = true },
				indent = { enable = true },
			}
			vim.opt.foldmethod = 'expr'
			vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
			---WORKAROUND
			vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
				group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
				callback = function()
					vim.opt.foldmethod = 'expr'
					vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
				end
			})
			---ENDWORKAROUND
		end
	}
	use { 'VonHeikemen/lsp-zero.nvim', -- Simple LSP setup
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		},
		config = function()
			local lsp = require('lsp-zero')
			local cmp = require('cmp')
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			lsp.on_attach(function(client, bufnr)
				local noremap = { buffer = bufnr, remap = false }
				local bind = vim.keymap.set

				bind('n', '##', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
				bind('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
				bind('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', noremap)
				bind('n', 'K', 'K', noremap)

			end)

			lsp.preset('recommended')
			lsp.setup_nvim_cmp({
				mapping = lsp.defaults.cmp_mappings({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				})
			})
			lsp.nvim_workspace()
			lsp.setup()
		end
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

local ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ok then return vim.notify('treesitter not loaded') end

ts.setup {
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	rainbow = { -- If rainbow parens are installed, this configures them
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	-- incremental_selection = { enable = true },
	textobjects = { enable = true },
	indent = { enable = true },
}

if not vim.wo.diff then
	vim.opt.foldmethod = 'expr'
	vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
end

---WORKAROUND for folding
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
	callback = function()
		if vim.wo.diff then return end
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
	end
})
---ENDWORKAROUND

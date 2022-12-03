local ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ok then return vim.notify('treesitter not loaded') end

ts.setup {
	auto_install = true,
	highlight = { enable = true },
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

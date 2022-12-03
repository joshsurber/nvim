local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then return vim.notify('toggleterm not loaded') end

toggleterm.setup({
	open_mapping = '<C-g>',
	direction = 'horizontal',
	shade_terminals = true
})

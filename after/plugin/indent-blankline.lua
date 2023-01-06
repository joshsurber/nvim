local ok, indentblankline = pcall(require, 'indent_blankline')
if not ok then return vim.notify('indent_blankline not loaded') end

indentblankline.setup({
	char = '▏',
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	use_treesitter = true,
	show_current_context = false
})

local lspOK, lsp = pcall(require, 'lsp-zero')
if not lspOK then return vim.notify('lspzero not loaded') end
local cmpOK, cmp = pcall(require, 'cmp')
if not cmpOK then return vim.notify('cmp not loaded') end
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

require("luasnip.loaders.from_snipmate").lazy_load()
vim.cmd [[ command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files() ]]

local ok, lsp = pcall(require, 'lsp-zero')
if not ok then return vim.notify('lspzero not loaded') end
local ok, cmp = pcall(require, 'cmp')
if not ok then return vim.notify('cmp not loaded') end
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.preset('recommended')
lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = false,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = 'local',
	sign_icons = {
		error = '✘',
		warn = '▲',
		hint = '⚑',
		info = ''
	}
})
lsp.setup_nvim_cmp({
	mapping = lsp.defaults.cmp_mappings({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
	})
})

for _, server in pairs({ "tsserver", "html" }) do
	-- Use null-ls and prettier instead for formatting
	return true or lsp.configure(server, {
		on_attach = function(client)
			client.server_capabilities.document_formatting = false
		end
	})
end

lsp.nvim_workspace()
lsp.setup()

require("luasnip.loaders.from_snipmate").lazy_load()
vim.cmd [[ command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files() ]]
vim.cmd [[ command! Format :lua vim.lsp.buf.format() ]]

vim.diagnostic.config({ virtual_text = true })

local ok, whichkey = pcall(require, 'which-key')
if not ok then return vim.notify('which-key not loaded') end

whichkey.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})

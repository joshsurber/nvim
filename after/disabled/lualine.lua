local ok, lualine = pcall(require, 'lualine')
if not ok then return vim.notify('lualine not loaded') end

lualine.setup({
	-- theme = 'gruvbox',
	theme = 'tokyonight',
	icons_enabled = true,
	-- sections = { lualine_c = { "%{ObsessionStatus()}" } }
	sections = { lualine_c = { require('auto-session-library').current_session_name } }
})

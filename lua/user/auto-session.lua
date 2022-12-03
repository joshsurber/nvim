local ok, autosession = pcall(require, 'autosession')
if not ok then return vim.notify('autosession not loaded') end

autosession.setup({
	log_level = "error",
	auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
})

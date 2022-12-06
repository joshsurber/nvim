local ok, wk = pcall(require, 'which-key')
if not ok then
	function WKRegister() end

	return vim.notify('which-key not loaded')
end

function WKRegister(key, desc)
	wk.register({
		[key] = { name = desc }
	})
end

wk.setup()

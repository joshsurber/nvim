local A = vim.api

-- Remove useless stuff from the terminal window and enter INSERT mode
A.nvim_create_autocmd('TermOpen', {
	callback = function(data)
		if not string.find(vim.bo[data.buf].filetype, '^[fF][tT]erm') then
			A.nvim_set_option_value('number', false, { scope = 'local' })
			A.nvim_set_option_value('relativenumber', false, { scope = 'local' })
			A.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
			A.nvim_command('startinsert')
		end
	end,
})

-- Help window on right, navigate helptags with enter and backspace
A.nvim_create_autocmd('FileType', {
	pattern = "help",
	callback = function()
		vim.cmd "wincmd L"
		vim.keymap.set('n', '<CR>', '<C-]>', { noremap = true, silent = true, buffer = true })
		vim.keymap.set('n', '<BS>', '<C-T>', { noremap = true, silent = true, buffer = true })
	end
})

-- Use relativenumber in current window only
local numbertoggle = A.nvim_create_augroup('numbertoggle', { clear = true })
A.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = numbertoggle,
	-- command =  "set relativenumber"
	callback = function()
		A.nvim_set_option_value('relativenumber', true, { scope = 'local' })
	end
})
A.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = numbertoggle,
	-- command =  "set norelativenumber"
	callback = function()
		A.nvim_set_option_value('relativenumber', false, { scope = 'local' })
	end
})

-- Do not use smart case in command line mode
local dynamic_smartcase = A.nvim_create_augroup('dynamic_smartcase', { clear = true })
A.nvim_create_autocmd('CmdLineEnter', {
	group = dynamic_smartcase,
	callback = function()
		A.nvim_set_option('smartcase', false)
	end
})
A.nvim_create_autocmd('CmdLineLeave', {
	group = dynamic_smartcase,
	callback = function()
		A.nvim_set_option('smartcase', true)
	end
})

-- Remove extra whitespace
vim.cmd "match ErrorMsg '\\s\\+$'"
A.nvim_create_autocmd('BufWritePre', {
	command = ':%s/\\s\\+$//e'
})

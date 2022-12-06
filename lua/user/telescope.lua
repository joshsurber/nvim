local ok, telescope = pcall(require, 'telescope')
if not ok then return vim.notify('Telescope not loaded') end

local function map(lhs, rhs, desc)
	-- All mappings begin with <leader>f
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>f' .. lhs, builtin[rhs], { desc = desc })
end

WKRegister('<leader>f', 'Find with Telescope')
map('f', 'find_files', "Find files")
map('g', 'live_grep', "Find with grep")
map('b', 'buffers', "Find in current buffers")
map('h', 'help_tags', "Find in help docs")
map('v', 'vim_options', "Find in Vim options")

require('user.set')
require('user.map')
require('user.colemak')
require('user.lazy')

local A = vim.api

-- Change CWD to current file's directory
A.nvim_create_user_command('CD', function()
    vim.cmd.cd(
        vim.fn.expand('%:h')
    )
end, {})

-- Help window on right, navigate helptags with enter and backspace
A.nvim_create_autocmd('FileType', {
    pattern = "help",
    callback = function()
        vim.cmd "wincmd L"
        vim.keymap.set('n', '<CR>', '<C-]>', { noremap = true, silent = true, buffer = true })
        vim.keymap.set('n', '<BS>', '<C-T>', { noremap = true, silent = true, buffer = true })
    end
})

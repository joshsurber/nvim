-- Change CWD to current file's directory
vim.api.nvim_create_user_command('CD', function()
    vim.cmd.cd(
        vim.fn.expand('%:h')
    )
end, {})

-- Help window on right, navigate helptags with enter and backspace
vim.api.nvim_create_autocmd('FileType', {
    pattern = "help",
    callback = function()
        vim.cmd "wincmd L"
        vim.keymap.set('n', '<CR>', '<C-]>', { noremap = true, silent = true, buffer = true })
        vim.keymap.set('n', '<BS>', '<C-T>', { noremap = true, silent = true, buffer = true })
    end

})
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = vim.keymap.set
        local opts = { buffer = event.buf }
        local buf = vim.lsp.buf

        map("n", "gh", buf.hover, { desc = "Floating information window" })
        map("n", "gH", buf.signature_help, { desc = "Signature information floating window" })
        map("n", "<leader>ld", buf.definition, { desc = "Go to definition" })
        map("n", "<leader>lD", buf.declaration, { desc = "Go to declaration" })
        map("n", "<leader>li", buf.implementation, { desc = "List implementations in quickfix window" })
        map("n", "<leader>lo", buf.type_definition, { desc = "Go to type definition" })
        map("n", "<leader>lR", buf.references, { desc = "List referencess in quickfix window" })
        map("n", "<leader>lr", buf.rename, { desc = "Rename symbol under cursor" })
        map("n", "<leader>la", buf.code_action, { desc = "Select a code action" })
        map("n", "<leader>lf", buf.format, { desc = "Format buffer" })
        -- map('n', '<leader>lF', '<cmd>%!prettier --stdin-filepath %<cr>', { desc = 'Format with prettier' })
        map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Show diagnostics in floating window" })
        -- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        -- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = ''
                },
            },
        })
        vim.cmd([[ command! Format :lua vim.lsp.buf.format() ]])
    end,
})

vim.keymap.set({ "n", "v" }, '<leader>h', require('nvim-emmet').wrap_with_abbreviation)

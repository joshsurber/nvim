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
        vim.cmd "wincmd I"
        vim.keymap.set('n', '<CR>', '<C-]>', { noremap = true, silent = true, buffer = true })
        vim.keymap.set('n', '<BS>', '<C-T>', { noremap = true, silent = true, buffer = true })
    end

})
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = vim.keymap.set
        local buf = vim.lsp.buf
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        map("n", "gh", buf.hover, { desc = "Floating information window" })
        map("n", "gH", buf.signature_help, { desc = "Signature information floating window" })
        map("n", "<leader>ld", buf.definition, { desc = "Go to definition" })
        map("n", "<leader>lD", buf.declaration, { desc = "Go to declaration" })
        map("n", "<leader>li", buf.implementation, { desc = "Go to implementation" })
        map("n", "<leader>lo", buf.type_definition, { desc = "Go to type definition" })
        map("n", "<leader>lR", buf.references, { desc = "List referencess in quickfix window" })
        map("n", "<leader>lr", buf.rename, { desc = "Rename symbol under cursor" })
        map("n", "<leader>la", buf.code_action, { desc = "Select a code action" })
        map("n", "<leader>lf", buf.format, { desc = "Format buffer" })
        -- map('n', '<leader>lF', '<cmd>%!prettier --stdin-filepath %<cr>', { desc = 'Format with prettier' })
        map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Show diagnostics in floating window" })

        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

-- Help window on right, navigate helptags with enter and backspace
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "*.txt" },
    callback = function()
        if not vim.o.filetype == "help" then
            return
        end
        vim.cmd.wincmd("L")
        vim.keymap.set("n", "<CR>", "<C-]>", { noremap = true, silent = true, buffer = true })
        vim.keymap.set("n", "<BS>", "<C-T>", { noremap = true, silent = true, buffer = true })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = vim.keymap.set
        local buf = vim.lsp.buf
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        map("n", "E", buf.hover, { desc = "Floating information window" })
        map("n", "grf", buf.format, { desc = "Format buffer" })

        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}
            for i = 32, 126 do
                table.insert(chars, string.char(i))
            end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        -- if not client:supports_method('textDocument/willSaveWaitUntil')
        --     and client:supports_method('textDocument/formatting') then
        --     vim.api.nvim_create_autocmd('BufWritePre', {
        --         group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        --         buffer = event.buf,
        --         callback = function()
        --             vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
        --         end,
        --     })
        -- end
    end,
})

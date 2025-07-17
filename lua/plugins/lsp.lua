local add = require("mini.deps").add
vim.lsp.config('lua_ls', {
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
        runtime = { version = 'LuaJIT', },
        workspace = { library = { vim.env.VIMRUNTIME, }, },
    }
})

vim.lsp.config('emmet_language_server', {
    filetypes = { "astro", "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
})
vim.keymap.set({ "n", "v" }, '<leader>h', require('nvim-emmet').wrap_with_abbreviation)

require("mason").setup({})
require("mason-lspconfig").setup({})

vim.opt.winborder = 'rounded'
vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true },
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

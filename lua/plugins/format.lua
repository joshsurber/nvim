local add = require("mini.deps").add
add("stevearc/conform.nvim")
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        css = { "prettierd" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
    },
    formatters = {
        stylua = { prepend_args = { "--indent-type", "Spaces" } },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
    },
    format_after_save = {
        lsp_format = "fallback",
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local add = require("mini.deps").add
add("stevearc/conform.nvim")
local prettier = { "prettierd", "prettier", stop_after_first = true }
local biome = { "biome", "biome-organize-imports" }
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        html = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        astro = prettier,
        json = prettier,
        jsonc = prettier,
        css = prettier,
        toml = { "taplo" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        bash = { "shfmt" },
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

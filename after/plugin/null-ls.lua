local ok, null_ls = pcall(require, 'null-ls')
if not ok then return vim.notify('null_ls not loaded') end

local code_action = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

null_ls.setup({
    sources = {
        -- fmt.stylua,
        -- formatting.tidy,
        formatting.prettier.with({ extra_filetypes = { "liquid" }, }),
        diagnostics.tidy,
        -- formatting.markdownlint,
        -- formatting.mdformat,
        formatting.shfmt,
    },
})

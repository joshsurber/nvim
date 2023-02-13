return {
    { 'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require('null-ls')

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
                    formatting.shfmt.with({ extra_args = { "-i", "4" } }),
                },
            })
        end
    },
} -- Inject 3rd party executables into LSP -- https://github.com/jose-elias-alvarez/null-ls.nvim

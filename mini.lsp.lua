return {
    'neovim/nvim-lspconfig',                 -- Required
    enabled=false,
    dependencies = {
        'williamboman/mason.nvim',           -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional{
        'rafamadriz/friendly-snippets',      -- Optional
    },
    config = function()
        local lspconfig = require('lspconfig')
        local lsp_defaults = lspconfig.util.default_config

        -- lsp_defaults.capabilities = vim.tbl_deep_extend(
        --         'force',
        --         lsp_defaults.capabilities,
        --         require('cmp_nvim_lsp').default_capabilities()
        --     )

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local map = vim.keymap.set
                local opts = { buffer = event.buf }
                local buf = vim.lsp.buf

                -- if client.name == "eslint" then
                --     vim.cmd.LspStop('eslint')
                --     return
                -- end

                -- LSP mappings
                map('n', 'gh', buf.hover, { desc = 'Floating information window' })
                map('n', 'gH', buf.signature_help, { desc = 'Signature information floating window' })
                map('n', '<leader>ld', buf.definition, { desc = 'Go to definition' })
                map('n', '<leader>lD', buf.declaration, { desc = 'Go to declaration' })
                map('n', '<leader>li', buf.implementation, { desc = 'List implementations in quickfix window' })
                map('n', '<leader>lo', buf.type_definition, { desc = 'Go to type definition' })
                map('n', '<leader>lR', buf.references, { desc = 'List referencess in quickfix window' })
                map('n', '<leader>lr', buf.rename, { desc = 'Rename symbol under cursor' })
                map('n', '<leader>la', buf.code_action, { desc = 'Select a code action' })
                map('n', '<leader>lf', buf.format, { desc = 'Format buffer' })
                -- map('n', '<leader>lF', '<cmd>%!prettier --stdin-filepath %<cr>', { desc = 'Format with prettier' })
                map('n', '<leader>ll', vim.diagnostic.open_float, { desc = 'Show diagnostics in floating window' })
                -- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
                -- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

                vim.diagnostic.config({ virtual_text = true })
                vim.cmd [[ command! Format :lua vim.lsp.buf.format() ]]
                --]]
            end
        })

        local default_setup = function(server)
            lspconfig[server].setup({})
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {},
            automatic_installation = true,
            handlers = {
                default_setup,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT'
                                },
                                diagnostics = {
                                    globals = { 'vim' },
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    }
                                }
                            }
                        }
                    })
                end,

            },
        })
    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function ()
            require("rust-tools").setup {}
        end
    }

    end,
}

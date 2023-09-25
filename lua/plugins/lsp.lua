return {
    { 'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig', -- Required
            'williamboman/mason.nvim', -- Optional
            'williamboman/mason-lspconfig.nvim', -- Optional

            -- Autocompletion
            'hrsh7th/nvim-cmp', -- Required
            'hrsh7th/cmp-nvim-lsp', -- Required
            'hrsh7th/cmp-buffer', -- Optional
            'hrsh7th/cmp-path', -- Optional
            'saadparwaiz1/cmp_luasnip', -- Optional
            'hrsh7th/cmp-nvim-lua', -- Optional

            -- Snippets
            'L3MON4D3/LuaSnip', -- Required
            'rafamadriz/friendly-snippets', -- Optional
        },
        config = function()
            local lsp=require('lsp-zero')
            local cmp=require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            lsp.preset('recommended')
            lsp.set_preferences({
                suggest_lsp_servers = true,
                setup_servers_on_start = true,
                set_lsp_keymaps = false,
                configure_diagnostics = true,
                cmp_capabilities = true,
                manage_nvim_cmp = true,
                call_servers = 'local',
                sign_icons = {
                    error = '✘',
                    warn = '▲',
                    hint = '⚑',
                    info = ''
                }
            })
            lsp.setup_nvim_cmp({
                mapping = lsp.defaults.cmp_mappings({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                })
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                local buf = vim.lsp.buf

                -- if client.name == "eslint" then
                --     vim.cmd.LspStop('eslint')
                --     return
                -- end

                -- LSP mappings
                vim.keymap.set('n', 'gh', buf.hover, { desc = 'Floating information window' })
                vim.keymap.set('n', 'gH', buf.signature_help, { desc = 'Signature information floating window' })
                vim.keymap.set('n', '<leader>ld', buf.definition, { desc = 'Go to definition' })
                vim.keymap.set('n', '<leader>lD', buf.declaration, { desc = 'Go to declaration' })
                vim.keymap.set('n', '<leader>li', buf.implementation,
                    { desc = 'List implementations in quickfix window' })
                vim.keymap.set('n', '<leader>lo', buf.type_definition, { desc = 'Go to type definition' })
                vim.keymap.set('n', '<leader>lR', buf.references, { desc = 'List referencess in quickfix window' })
                vim.keymap.set('n', '<leader>lr', buf.rename, { desc = 'Rename symbol under cursor' })
                vim.keymap.set('n', '<leader>la', buf.code_action, { desc = 'Select a code action' })
                vim.keymap.set('n', '<leader>lf', buf.format, { desc = 'Format buffer' })
                vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float,
                    { desc = 'Show diagnostics in floating window' })
                -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
                -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
            end)

            lsp.nvim_workspace()
            lsp.setup()

            require("luasnip.loaders.from_snipmate").lazy_load()
            vim.cmd [[ command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files() ]]
            vim.cmd [[ command! Format :lua buf.format() ]]

            vim.diagnostic.config({ virtual_text = true })
        end,
    },
}

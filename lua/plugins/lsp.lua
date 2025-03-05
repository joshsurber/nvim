local add = require("mini.deps").add

add({ source = "neovim/nvim-lspconfig" })
add("rafamadriz/friendly-snippets")
add({
    source = "williamboman/mason.nvim",
    depends = {
        "williamboman/mason-lspconfig.nvim",
        -- "mhartington/formatter.nvim",
    },
})

require("mason").setup({})
require("mason-lspconfig").setup({

    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {},
    automatic_installation = true,
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    },
                },
            })
        end,
        emmet_language_server = function()
            require("lspconfig").emmet_language_server.setup({
                filetypes = { "astro", "css", "eruby", "html", "javascript",
                    "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
                settings = {
                },
            })
        end,
    },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
    },
})

vim.opt.signcolumn = "yes"

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

add("olrtg/nvim-emmet") -- requires emmet-language-server
vim.keymap.set({ "n", "v" }, '<leader>h', require('nvim-emmet').wrap_with_abbreviation)

-- -- Utilities for creating configurations
-- local util = require "formatter.util"
-- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- require("formatter").setup {
--   logging = true,
--   log_level = vim.log.levels.WARN,
--
--   filetype = {
--     -- Formatter configurations for filetype "lua" go here
--     -- and will be executed in order
--     lua = {
--       -- "formatter.filetypes.lua" defines default configurations for the
--       -- "lua" filetype
--       require("formatter.filetypes.lua").stylua,
--
--       -- You can also define your own configuration
--       function()
--         -- Supports conditional formatting
--         if util.get_current_buffer_file_name() == "special.lua" then
--           return nil
--         end
--
--         -- Full specification of configurations is down below and in Vim help
--         -- files
--         return {
--           exe = "stylua",
--           args = {
--             "--search-parent-directories",
--             "--stdin-filepath",
--             util.escape_path(util.get_current_buffer_file_path()),
--             "--",
--             "-",
--           },
--           stdin = true,
--         }
--       end
--     },
--
--     -- Use the special "*" filetype for defining formatter configurations on
--     -- any filetype
--     ["*"] = {
--       -- "formatter.filetypes.any" defines default configurations for any
--       -- filetype
--       require("formatter.filetypes.any").remove_trailing_whitespace,
--       -- Remove trailing whitespace without 'sed'
--       -- require("formatter.filetypes.any").substitute_trailing_whitespace,
--     }
--   }
-- }

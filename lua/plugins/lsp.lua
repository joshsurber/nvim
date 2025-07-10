local add = require("mini.deps").add
add({ -- lsp
    source = "neovim/nvim-lspconfig",
    depends = {
        "rafamadriz/friendly-snippets",
        "olrtg/nvim-emmet",
    },
})
add({ -- mason
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

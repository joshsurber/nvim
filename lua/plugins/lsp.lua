local add = MiniDeps.add

add({ source = "neovim/nvim-lspconfig" })
add({
    source = "hrsh7th/nvim-cmp",
    depends = { "hrsh7th/cmp-nvim-lsp", "rafamadriz/friendly-snippets" },
})

add({
    source = "williamboman/mason.nvim",
    depends = { "williamboman/mason-lspconfig.nvim" },
})
require("mason").setup({})
require("mason-lspconfig").setup({

    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    },
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

-- Reserve a space in the gutter
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        --[[
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        ]]
        local map = vim.keymap.set
        local opts = { buffer = event.buf }
        local buf = vim.lsp.buf

        -- if client.name == "eslint" then
        --     vim.cmd.LspStop('eslint')
        --     return
        -- end

        -- LSP mappings
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

        vim.diagnostic.config({ virtual_text = true })
        vim.cmd([[ command! Format :lua vim.lsp.buf.format() ]])
        --]]
    end,
})

local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({}),
})

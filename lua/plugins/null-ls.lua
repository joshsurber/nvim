require("mini.deps").add({
    source = "nvimtools/none-ls.nvim",
    depends = {
        "jay-babu/mason-null-ls.nvim",
    },
})

local null_ls = require("null-ls")
local code_action = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

-- null_ls.setup({
-- 	sources = {
-- 		-- fmt.stylua,
-- 		-- formatting.tidy,
-- 		formatting.prettier.with({ extra_filetypes = { "liquid" } }),
-- 		diagnostics.tidy,
-- 		-- formatting.markdownlint,
-- 		-- formatting.mdformat,
-- 		formatting.shfmt.with({ extra_args = { "-i", "4" } }),
-- 	},
-- })

-- require("mason-null-ls").setup({
-- 	handlers = {},
-- 	automatic_installation = true,
-- })

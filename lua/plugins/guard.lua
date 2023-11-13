return {
    "nvimdev/guard.nvim",
    enabled = false,
    -- Builtin configuration, optional
    dependencies = {
        "nvimdev/guard-collection",
    },

    config = function()
        local ft = require('guard.filetype')

        ft('html,css,typescript,javascript,typescriptreact'):fmt('prettier')

        -- Call setup() LAST!
        require('guard').setup({
            -- the only options for the setup function
            fmt_on_save = true,
            -- Use lsp if no formatter was defined for this filetype
            lsp_as_default_formatter = false,
        })
    end,
}

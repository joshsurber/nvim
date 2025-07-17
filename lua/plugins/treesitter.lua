local add = require("mini.deps").add
add({ -- treesitter
    source = "nvim-treesitter/nvim-treesitter",
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    depends = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-context",
        "HiPhish/rainbow-delimiters.nvim",
    },
})

require("nvim-treesitter.configs").setup({
    build = ":TSUpdate",
    auto_install = true,
    indent = { enable = true },
    highlight = {
        enable = true,
        --[[ additional_vim_regex_highlighting = true, ]]
    },
    incremental_selection = {
        enable = false, -- throws error with minicomment
        keymaps = {
            init_selection = "gnn",
            node_incrementalc = "grn",
            scope_incrementan = "grc",
            node_decremental = "grm",
        },
    },
    textobjects = {
        enable = false,
        select = {
            enable = true,

            -- Automatically jump forward to textobjects, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            include_surrounding_whitespace = true,
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = "none",
            peek_definition_code = {
                ["<leader>lp"] = "@function.outer",
                ["<leader>lP"] = "@class.outer",
            },
        },
    },
    textsubjects = {
        enable = false,
        prev_selection = ",", -- (Optional) keymap to select the previous selection
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
        },
    },
})

require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true,           -- Auto close tags
        enable_rename = true,          -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
        -- ["html"] = {
        --   enable_close = false
        -- }
    },
})

require 'treesitter-context'.setup {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false,      -- Enable multiwindow support.
    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- -- Use treesitter to manage folds
-- if not vim.wo.diff then
--     vim.opt.foldmethod = "expr"
--     vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- end

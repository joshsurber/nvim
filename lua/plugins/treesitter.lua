-- Use treesitter to manage folds
if not vim.wo.diff then
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
end

return {
    'mrjones2014/nvim-ts-rainbow', -- Rainbow parentheses
    'nvim-treesitter/nvim-treesitter-context', -- Where am I in my code -- https://github.com/nvim-treesitter/nvim-treesitter-context
    -- 'nvim-treesitter/playground', -- https://github.com/nvim-treesitter/playground
    'windwp/nvim-ts-autotag', -- Auto close tags and rename in pairs -- https://github.com/windwp/nvim-ts-autotag
    { 'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            auto_install = true,
            indent = { enable = true, },
            autotag = { enable = true, },
            highlight = { enable = true, --[[ additional_vim_regex_highlighting = true, ]] },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "gnn",
                    node_incrementalc = "grn",
                    scope_incrementan = "grc",
                    node_decremental = "grm",
                },
            },
            rainbow = { -- If rainbow parens are installed, this configures them
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
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
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
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
                enable = true,
                prev_selection = ',', -- (Optional) keymap to select the previous selection
                keymaps = {
                    ['.'] = 'textsubjects-smart',
                    [';'] = 'textsubjects-container-outer',
                    ['i;'] = 'textsubjects-container-inner',
                },
            },
        }
    }, -- Language awareness -- https://github.com/nvim-treesitter/nvim-treesitter
}

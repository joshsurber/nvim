return {
    'nvim-telescope/telescope.nvim', -- Fuzzy file finder -- https://github.com/nvim-telescope/telescope.nvim
    config = function()
        local leader = '<leader>f' -- For all telescope commands
        local actions = require "telescope.actions"
        local builtin = require('telescope.builtin')
        local function map(lhs, rhs, desc)
            -- All mappings begin with <leader>f
            vim.keymap.set('n', leader .. lhs, builtin[rhs], { desc = desc })
        end

        map('"', 'registers', 'Registers')
        map('*', 'colorscheme', 'Available colorschemes')
        map('/', 'search_history', 'Previous searches')
        map(':', 'command_history', 'Previously run commands')
        map('\'', 'marks', 'Marks')
        map('b', 'buffers', "Find in current buffers")
        map('b', 'builtin', 'List builtin searches')
        map('c', 'current_buffer_fuzzy_find', 'Current buffer')
        map('f', 'find_files', "Find files")
        map('g', 'live_grep', "Find with grep")
        map('GS', 'git_stash', 'Stash')
        map('Gb', 'git_branches', 'Branches')
        map('Gc', 'git_commits', 'Git commits')
        map('Gf', 'git_files', 'Git tracked files')
        map('Gs', 'git_status', 'Status')
        map('h', 'help_tags', "Find in help docs")
        map('k', 'keymaps', 'Keymaps')
        map('q', 'quickfix', 'Quickfix list')
        map('r', 'oldfiles', "Open recent file")
        map('t', 'treesitter', 'Search TreeSitter symbols')
        map('v', 'vim_options', "Find in Vim options")

        return {
            defaults = {

                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },

                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,

                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,

                        ["<C-c>"] = actions.close,

                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,

                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-l>"] = actions.complete_tag,
                        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                    },

                    n = {
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,

                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["gg"] = actions.move_to_top,
                        ["G"] = actions.move_to_bottom,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["?"] = actions.which_key,
                    },
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            },
        }
    end
}

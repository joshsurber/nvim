return {
    'echasnovski/mini.nvim', -- Small utilities -- https://github.com/echasnovski/mini.nvim
    config = function()
        local modules = {
            'ai', -- Extend and create `a`/`i` textobjects          -- miniai
            -- 'align' , -- Align text interactively                   -- minialign
            'animate', -- Animate common Neovim actions             -- minianimate
            -- 'base16' , -- Base16 colorscheme creation               -- minibase16
            'basics', -- Common config presets                    -- minibasics
            'bracketed', -- Go forward/backward with square brackets -- minibracketed
            'bufremove', -- Remove buffers                          -- minibufremove
            'clue', -- Show next key clues                          -- miniclue
            'colors', -- Tweak and save any color scheme            -- minicolors
            'comment', -- Comment                                   -- minicomment
            -- 'completion' , -- Completion and signature help         -- minicompletion
            'cursorword', -- Autohighlight word under cursor        -- minicursorword
            -- 'doc' , -- Generate Neovim help files                   -- minidoc
            'files', -- Navigate and manipulate file system         -- minifiles
            -- 'fuzzy' , -- Fuzzy matching                             -- minifuzzy
            'hipatterns', -- Highlight patterns in text             -- minihipatterns
            'indentscope', -- Visualize and operate on indent scope -- miniindentscope
            'jump', -- Jump forward/backward to a single character  -- minijump
            'jump2d', -- Jump within visible lines                  -- minijump2d
            -- 'map' , -- Window with buffer text overview             -- minimap
            -- 'misc' , -- Miscellaneous functions                     -- minimisc
            'move', -- Move any selection in any direction          -- minimove
            -- 'operators', -- Text edit operators                     -- minioperators
            'pairs', -- Autopairs                                   -- minipairs
            'sessions', -- Session management                       -- minisessions
            'splitjoin', -- Split and join arguments                -- minisplitjoin
            'starter', -- Start screen                              -- ministarter
            'statusline', -- Statusline                             -- ministatusline
            'surround', -- Surround actions                         -- minisurround
            'tabline', -- Tabline                                   -- minitabline
            -- 'test' , -- Test Neovim plugins                         -- minitest
            'trailspace', -- Trailspace (highlight and remove)      -- minitrailspace
        }

        local config = {
            basics = {
                options = {
                    extra_ui = true,
                    -- win_borders = 'default',
                },
                mappings = {
                    windows = true, -- Window navigation with <C-hjkl>, resize with <C-arrow>
                    move_with_alt = true, -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
                },
                autocommands = {
                    relnum_in_visual_mode = true,
                },
            },
            bufremove = {
                after = function()
                    vim.keymap.set("n", "<leader>q", "<cmd>lua MiniBufremove.wipeout()<cr>",
                        { desc = 'Wipeout buffer (close tab)' })
                end
            },
            clue = {
                window = {
                    delay = 250,
                },
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },

                    -- mini.surround
                    { mode='n', keys='s'},
                    { mode='v', keys='s'},

                    -- mini.bracketed
                    {mode='n',keys='['},
                    {mode='n',keys=']'},
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    require('mini.clue').gen_clues.builtin_completion(),
                    require('mini.clue').gen_clues.g(),
                    require('mini.clue').gen_clues.marks(),
                    require('mini.clue').gen_clues.registers(),
                    require('mini.clue').gen_clues.windows(),
                    require('mini.clue').gen_clues.z(),

                    { mode = 'i', keys = '<C-x><C-f>', desc = 'File names' },
                    { mode = 'i', keys = '<C-x><C-l>', desc = 'Whole lines' },
                    { mode = 'i', keys = '<C-x><C-o>', desc = 'Omni completion' },
                    { mode = 'i', keys = '<C-x><C-s>', desc = 'Spelling suggestions' },
                    { mode = 'i', keys = '<C-x><C-u>', desc = "With 'completefunc'" },

                    { mode = 'n', keys = '<leader>f',  desc = 'Find with Telescope' },
                    { mode = 'n', keys = '<leader>l',  desc = 'LSP' },
                    { mode = 'n', keys = '<leader>g',  desc = 'Git' },
                    { mode = 'n', keys = '<leader>v',  desc = 'Vim config' },
                },
            },
            hipatterns = {
                highlighters = {
                    fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
                    hack  = { pattern = 'HACK', group = 'MiniHipatternsHack' },
                    todo  = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
                    note  = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
                },
            },
            files = {
                after = function()
                    vim.notify('foobar')
                    vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>",
                        { desc = 'Open file explorer' })
                end,
            },
            sessions = {
                after = function()
                    vim.api.nvim_create_user_command('Screate', function()
                        vim.ui.input({
                            prompt = 'Session name? ',
                        }, function(input) MiniSessions.write(input) end)
                    end, {})

                    vim.api.nvim_create_user_command('Sdelete', function()
                        MiniSessions.select('delete')
                    end, {})

                    vim.api.nvim_create_user_command('Sload', function()
                        MiniSessions.select()
                    end, {})

                    vim.api.nvim_create_user_command('Ssave', function()
                        MiniSessions.write()
                    end, {})
                end
            },
            starter = {
                after = function()
                    vim.api.nvim_create_user_command('Start', function()
                        MiniStarter.open()
                    end, {})
                end
            },
            trailspace = {
                after = function()
                    -- Delete trailing space on write
                    vim.api.nvim_create_autocmd('BufWritePre', { callback = MiniTrailspace.trim })
                    vim.api.nvim_create_autocmd('BufWritePre', { callback = MiniTrailspace.trim_last_lines })
                end
            }
        }

        if Colemak then
            if not config.move then config.move = {} end
            config.move.mappings = {
                -- only for Colemak
                down = '<M-n>',
                up = '<M-e>',
                right = '<M-i>',
                line_down = '<M-n>',
                line_up = '<M-e>',
                line_right = '<M-i>',
            }
            if not config.files then config.files = {} end
            config.files.mappings = {
                go_in      = 'i',
                go_in_plus = 'I',
            }
        end

        for _, module in pairs(modules) do
            local opts = config[module] or {}
            require('mini.' .. module).setup(opts)
            if config[module] and config[module].after then pcall(config[module].after) end
        end
    end
}
-- vim: fdl=2

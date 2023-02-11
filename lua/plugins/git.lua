return {
    { 'tpope/vim-fugitive' }, -- Git integration -- https://github.com/tpope/vim-fugitive
    { 'lewis6991/gitsigns.nvim', -- Track git changes in gutter -- https://github.com/lewis6991/gitsigns.nvim
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                local function lmap(mode, l, r, opts)
                    local leader = '<leader>g'
                    l = leader .. l
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Goto next changed hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Goto previous changed hunk' })

                -- Actions
                lmap({ 'n', 'v' }, 's', function() vim.cmd.Gitsigns('stage_hunk') end, { desc = "Stage hunk" })
                lmap({ 'n', 'v' }, 'r', function() vim.cmd.Gitsigns('reset_hunk') end, { desc = "Reset hunk" })
                lmap('n', 'S', gs.stage_buffer, { desc = "Stage buffer" })
                lmap('n', 'u', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                lmap('n', 'R', gs.reset_buffer, { desc = "Reset buffer" })
                lmap('n', 'p', gs.preview_hunk, { desc = "Preview hunk" })
                lmap('n', 'b', function() gs.blame_line { full = true } end, { desc = "Blame line" })
                lmap('n', 'tb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                lmap('n', 'd', gs.diffthis, { desc = "Diff hunk" })
                lmap('n', 'D', function() gs.diffthis('~') end, { desc = "Diff buffer" })
                lmap('n', 'td', gs.toggle_deleted, { desc = "Toggle deleted" })
                -- lmap('n', 't', '<esc>', { desc = "Toggle" })
                lmap('n', 'g', function() vim.cmd.Git() end, { desc = "Open Git status with fugitive" }) -- fugitive
                lmap('n', 'c', function() vim.cmd.Git('commit') end, { desc = "Git commit" }) -- fugitive
                lmap('n', 'P', function() vim.cmd.Git('push') end, { desc = "Git push" }) -- fugitive

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        },
    }
}

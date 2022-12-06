local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return vim.notify('gitsigns not loaded') end

gitsigns.setup {
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
		WKRegister('<leader>g', "Git commands")
		lmap({ 'n', 'v' }, 's', ':Gitsigns stage_hunk<CR>', { desc = "Stage hunk" })
		lmap({ 'n', 'v' }, 'r', ':Gitsigns reset_hunk<CR>', { desc = "Reset hunk" })
		lmap('n', 'S', gs.stage_buffer, { desc = "Stage buffer" })
		lmap('n', 'u', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
		lmap('n', 'R', gs.reset_buffer, { desc = "Reset buffer" })
		lmap('n', 'p', gs.preview_hunk, { desc = "Preview hunk" })
		lmap('n', 'b', function() gs.blame_line { full = true } end, { desc = "Blame line" })
		lmap('n', 'tb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
		lmap('n', 'd', gs.diffthis, { desc = "Diff hunk" })
		lmap('n', 'D', function() gs.diffthis('~') end, { desc = "Diff buffer" })
		lmap('n', 'td', gs.toggle_deleted, { desc = "Toggle deleted" })
		lmap('n', 't', '<esc>', { desc = "Toggle" })
		lmap('n', 'g', '<cmd>Git<cr>', { desc = "Open Git status with fugitive" })
		lmap('n', 'c', '<cmd>Git commit<cr>', { desc = "Git commit" })

		-- Text object
		map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}

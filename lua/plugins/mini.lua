if not vim.g.neovide then
	-- Get this first since it depends on whether in Terminal or Neovide
	require("mini.animate").setup()
end

local modules = {
	-- 'animate',     -- Leave commented; applied first but not in Neovide

	"ai", -- Extend and create `a`/`i` textobjects                 -- miniai
	"align", -- Align text interactively                              -- minialign
	"basics", -- Common config presets                                 -- minibasics
	"bracketed", -- Go forward/backward with square brackets              -- minibracketed
	"bufremove", -- Remove buffers                                        -- minibufremove
	"clue", -- Show next key clues                                   -- miniclue
	"comment", -- Comment                                               -- minicomment
	"completion", -- Completion and signature help                         -- minicompletion
	"cursorword", -- Autohighlight word under cursor                       -- minicursorword
	"diff", -- Work with diff hunks                                  -- minidiff
	"extra", -- Extra mini.nvim functionality                         -- miniextra
	"files", -- Navigate and manipulate file system                   -- minifiles
	"git", -- Git integration                                       -- minigit
	"hipatterns", -- Highlight patterns in text                            -- minihipatterns
	"icons", -- Icon provider                                         -- miniicons
	"indentscope", -- Visualize and operate on indent scope                 -- miniindentscope
	"jump", -- Jump forward/backward to a single character           -- minijump
	"jump2d", -- Jump within visible lines                             -- minijump2d
	"move", -- Move any selection in any direction                   -- minimove
	"notify", -- Show notifications                                    -- mininotify
	"operators", -- Text edit operators                                   -- minioperators
	"pairs", -- Autopairs                                             -- minipairs
	"pick", -- Pick anything                                         -- minipick
	"sessions", -- Session management                                    -- minisessions
	"snippets", -- Manage and expand snippets                            -- minisnippets
	"splitjoin", -- Split and join arguments                              -- minisplitjoin
	"starter", -- Start screen                                          -- ministarter
	"statusline", -- Statusline                                            -- ministatusline
	"surround", -- Surround actions                                      -- minisurround
	"tabline", -- Tabline                                               -- minitabline
	"trailspace", -- Trailspace (highlight and remove)                     -- minitrailspace
	"visits", -- Track and reuse file system visits                    -- minivisits
	-- 'base16' ,           -- Base16 colorscheme creation                           -- minibase16
	-- 'colors',            -- Tweak and save any color scheme                       -- minicolors
	-- 'deps',              -- Plugin manager                                        -- minideps
	-- 'doc' ,              -- Generate Neovim help files                            -- minidoc
	-- 'fuzzy' ,            -- Fuzzy matching                                        -- minifuzzy
	-- 'map' ,              -- Window with buffer text overview                      -- minimap
	-- 'misc' ,             -- Miscellaneous functions                               -- minimisc
	-- 'test' ,             -- Test Neovim plugins                                   -- minitest
}

local config = {
	basics = {
		options = {
			extra_ui = true,
			-- win_borders = 'default',
		},
		mappings = {
			-- windows = true,       -- Window navigation with <C-hjkl>, resize with <C-arrow>
			move_with_alt = true, -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
		},
		autocommands = {
			relnum_in_visual_mode = true,
		},
	},
	bufremove = {
		after = function()
			vim.keymap.set(
				"n",
				"<leader>q",
				"<cmd>lua MiniBufremove.wipeout()<cr>",
				{ desc = "Wipeout buffer (close tab)" }
			)
		end,
	},
	clue = {
		-- window = {
		--     delay = 250,
		-- },
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },

			-- mini.surround
			{ mode = "n", keys = "s" },
			{ mode = "v", keys = "s" },

			-- mini.bracketed
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },

			-- mini.basics
			{ mode = "n", keys = "\\" },
		},

		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			require("mini.clue").gen_clues.builtin_completion(),
			require("mini.clue").gen_clues.g(),
			require("mini.clue").gen_clues.marks(),
			require("mini.clue").gen_clues.registers(),
			require("mini.clue").gen_clues.windows(),
			require("mini.clue").gen_clues.z(),

			{ mode = "i", keys = "<C-x><C-f>", desc = "File names" },
			{ mode = "i", keys = "<C-x><C-l>", desc = "Whole lines" },
			{ mode = "i", keys = "<C-x><C-o>", desc = "Omni completion" },
			{ mode = "i", keys = "<C-x><C-s>", desc = "Spelling suggestions" },
			{ mode = "i", keys = "<C-x><C-u>", desc = "With 'completefunc'" },
			-- { mode = 'n', keys = '<leader>f',  desc = 'Find with Telescope' },
			{ mode = "n", keys = "<leader>f", desc = "Find with MiniPick" },
			{ mode = "n", keys = "<leader>p", desc = "Pick stuff" },
			{ mode = "n", keys = "<leader>l", desc = "LSP" },
			{ mode = "n", keys = "<leader>g", desc = "Git" },
			{ mode = "n", keys = "<leader>v", desc = "Vim config" },
		},
	},
	completion = {
		lsp_completion = {
			source_func = "omnifunc",
		},
		after = function()
			local imap_expr = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true })
			end

			-- local keycode = vim.keycode or function(x)
			--     return vim.api.nvim_replace_termcodes(x, true, true, true)
			-- end
			-- local keys = {
			--     ['cr']        = keycode('<CR>'),
			--     ['ctrl-y']    = keycode('<C-y>'),
			--     ['ctrl-y_cr'] = keycode('<C-y><CR>'),
			-- }

			imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
			imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

			-- _G.cr_action = function()
			--     if vim.fn.pumvisible() ~= 0 then
			--         -- If popup is visible, confirm selected item or add new line otherwise
			--         local item_selected = vim.fn.complete_info()['selected'] ~= -1
			--         return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
			--     else
			--         -- If popup is not visible, use plain `<CR>`. You might want to customize
			--         -- according to other plugins. For example, to use 'mini.pairs', replace
			--         -- next line with `return require('mini.pairs').cr()`
			--         return keys['cr']
			--     end
			-- end

			-- vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
		end,
	},
	diff = {
		view = {
			-- style = 'sign',
			signs = { add = "+", change = "~", delete = "-" },
		},
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			apply = "<leader>gh",
			reset = "<leader>gH",
		},
	},
	hipatterns = {
		highlighters = {
			fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
			hack = { pattern = "HACK", group = "MiniHipatternsHack" },
			todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
			note = { pattern = "NOTE", group = "MiniHipatternsNote" },
		},
	},
	files = {
		after = function()
			vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open file explorer" })
		end,
	},
	git = {
		-- Options for `:Git` command
		command = {
			-- Default split direction
			split = "horizontal",
		},
		after = function()
			local function lmap(mode, l, r, opts)
				local leader = "<leader>g"
				l = leader .. l
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end
			-- Actions
			lmap("n", "g", function()
				vim.cmd.Git("status")
			end, { desc = "Git status" })
			lmap("n", "c", function()
				vim.cmd.Git("commit")
			end, { desc = "Git commit" })
			lmap("n", "P", function()
				vim.cmd.Git("push")
			end, { desc = "Git push" })
			lmap({ "n", "x" }, "s", "<Cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Show at cursor" })
		end,
	},
	operators = {
		-- [[
		evaluate = { prefix = "<leader>=" },
		exchange = { prefix = "<leader>x" },
		multiply = { prefix = "<leader>m" },
		replace = { prefix = "<leader>r" },
		sort = { prefix = "<leader>S" },
		--]]
	},
	pick = {
		after = function()
			local function map(lhs, rhs, desc)
				-- All mappings begin with <leader>f
				vim.keymap.set("n", "<leader>f" .. lhs, "<cmd>Pick " .. rhs .. "<cr>", { desc = desc })
			end
			map("f", "files", "Pick files")
			map("b", "buffers", "Pick buffers")
			map("g", "grep_live", "Pick grep_live")
			map("G", "grep", "Pick grep")
			map("h", "help", "Pick help")
			map("r", "resume", "Resume last pick")
		end,
	},
	sessions = {
		after = function()
			vim.api.nvim_create_user_command("Screate", function()
				vim.ui.input({
					prompt = "Session name? ",
				}, function(input)
					MiniSessions.write(input)
				end)
			end, {})

			vim.api.nvim_create_user_command("Sdelete", function()
				MiniSessions.select("delete")
			end, {})

			vim.api.nvim_create_user_command("Sload", function()
				MiniSessions.select()
			end, {})

			vim.api.nvim_create_user_command("Ssave", function()
				MiniSessions.write()
			end, {})
		end,
	},
	snippets = {
		snippets = {
			-- Load custom file with global snippets first (adjust for Windows)
			require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),

			-- Load snippets based on current language by reading files from
			-- "snippets/" subdirectories from 'runtimepath' directories.
			require("mini.snippets").gen_loader.from_lang(),
		},
		mappings = {
			-- Expand snippet at cursor position. Created globally in Insert mode.
			expand = "<C-n>",

			-- Interact with default `expand.insert` session.
			-- Created for the duration of active session(s)
			jump_next = "<C-i>",
			jump_prev = "<C-h>",
			stop = "<C-c>",
		},
	},
	starter = {
		after = function()
			vim.api.nvim_create_user_command("Start", function()
				MiniStarter.open()
			end, {})
		end,
	},
	trailspace = {
		after = function()
			-- Delete trailing space on write
			vim.api.nvim_create_autocmd("BufWritePre", { callback = MiniTrailspace.trim })
			vim.api.nvim_create_autocmd("BufWritePre", { callback = MiniTrailspace.trim_last_lines })
		end,
	},
}

if Colemak then
	if not config.move then
		config.move = {}
	end
	config.move.mappings = {
		-- only for Colemak
		down = "<M-n>",
		up = "<M-e>",
		right = "<M-i>",
		line_down = "<M-n>",
		line_up = "<M-e>",
		line_right = "<M-i>",
	}
	if not config.files then
		config.files = {}
	end
	config.files.mappings = {
		go_in = "i",
		go_in_plus = "I",
	}
end

for _, module in pairs(modules) do
	local opts = config[module] or {}
	require("mini." .. module).setup(opts)
	if config[module] and config[module].after then
		pcall(config[module].after)
	end
end
-- vim: fdl=2

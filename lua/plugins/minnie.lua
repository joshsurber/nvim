if not vim.g.neovide then
    require("mini.animate").setup()
end

require("mini.ai").setup() -- Extend and create `a`/`i` textobjects
-- require("mini.align").setup() -- Align text interactively
-- require("mini.base16").setup() -- Base16 colorscheme creation
require("mini.basics").setup({ -- Common config presets{{{
    options = {
        -- extra_ui = true,
        -- win_borders = 'default',
    },
    mappings = {
        -- windows = true,       -- Window navigation with <C-hjkl>, resize with <C-arrow>
        -- move_with_alt = true, -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
    },
    autocommands = {
        relnum_in_visual_mode = true,
    },
}) -- }}}
require("mini.bracketed").setup() -- Go forward/backward with square brackets
require("mini.bufremove").setup() -- Remove buffers{{{
vim.keymap.set("n", "<leader>q", "<cmd>lua MiniBufremove.wipeout()<cr>", { desc = "Wipeout buffer (close tab)" }) -- }}}
-- require("mini.colors").setup() -- Tweak and save any color scheme
require("mini.clue").setup({ -- Show next key clues{{{
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
        { mode = "n", keys = "<leader>f", desc = "Find with MiniPick" },
        -- { mode = "n", keys = "<leader>g", desc = "Git" },
        -- { mode = "n", keys = "<leader>l",  desc = "LSP" },
        -- { mode = "n", keys = "<leader>m", desc = "MiniMap" },
        { mode = "n", keys = "<leader>p", desc = "Pick stuff" },
        { mode = "n", keys = "<leader>v", desc = "Vim config" },
    },
}) -- }}}
require("mini.cmdline").setup()
-- require("mini.comment").setup() -- Comment
require("mini.completion").setup({ -- Completion and signature help{{{
    lsp_completion = {
        source_func = "omnifunc",
        -- source_func = "completefunc",
    },
    after = function() end,
})
local imap_expr = function(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { expr = true })
end

imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
imap_expr("<CR>", [[pumvisible() ? "\<C-y>" : "\<CR>"]])
-- }}}
require("mini.cursorword").setup() -- Autohighlight word under cursor
require("mini.deps").setup() -- Plugin manager{{{
vim.keymap.set("n", "<leader>vp", require("mini.deps").update, { desc = "Sync plugins" }) -- }}}
require("mini.diff").setup({ -- Work with diff hunks{{{
    view = {
        -- style = "sign",
        signs = { add = "+", change = "!", delete = "-" },
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        apply = "<leader>gh",
        reset = "<leader>gH",
    },
}) -- }}}
-- require("mini.doc").setup() -- Generate Neovim help files
-- require("mini.extra").setup() -- Extra mini.nvim functionality
-- require("mini.fuzzy").setup() -- Fuzzy matching
require("mini.files").setup({ -- Navigate and manipulate file system{{{
    windows = {
        preview = true,
        width_preview = 50,
    },
    mappings = { -- Colemak
        go_in = "i",
        go_in_plus = "I",
    },
})

-- Show/hide filexplorer
local minifiles_toggle = function(...)
    if not MiniFiles.close() then
        MiniFiles.open(...)
    end
end
vim.keymap.set("n", "<leader>e", minifiles_toggle, { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>e", require('mini.files').open, { desc = "Open file explorer" })

-- Dotfiles
local show_dotfiles = true
local filter_show = function(fs_entry)
    return true
end
local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end
local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
    end,
})
-- }}}
require("mini.git").setup({ -- Git integration{{{
    -- Options for `:Git` command
    command = {
        -- Default split direction
        split = "horizontal",
    },
})

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
-- }}}
require("mini.hipatterns").setup({ -- Highlight patterns in text{{{
    highlighters = {
        fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
        hack = { pattern = "HACK", group = "MiniHipatternsHack" },
        todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
        note = { pattern = "NOTE", group = "MiniHipatternsNote" },
    },
}) -- }}}
require("mini.icons").setup() -- Icon provider
require("mini.indentscope").setup() -- Visualize and operate on indent scope
require("mini.jump").setup() -- Jump forward/backward to a single character
require("mini.jump2d").setup() -- Jump within visible lines
-- require("mini.map").setup() -- Window with buffer text overview{{{
--             local map = vim.keymap.set
--             local MiniMap = Minimap
--             map("n", "<Leader>mc", MiniMap.close, { desc = "Close map" })
--             map("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "Focus map" })
--             map("n", "<Leader>mo", MiniMap.open, { desc = "Open map" })
--             map("n", "<Leader>mr", MiniMap.refresh, { desc = "Refresh map" })
--             map("n", "<Leader>ms", MiniMap.toggle_side, { desc = "Switch map side" })
--             map("n", "<Leader>mt", MiniMap.toggle, { desc = "Toggle map" })
-- -- }}}
-- require("mini.misc").setup() -- Miscellaneous functions
require("mini.move").setup({ -- Move any selection in any direction{{{
    mappings = {
        -- only for Colemak
        down = "<M-n>",
        up = "<M-e>",
        right = "<M-i>",
        line_down = "<M-n>",
        line_up = "<M-e>",
        line_right = "<M-i>",
    },
}) -- }}}
require("mini.notify").setup() -- Show notifications
-- require("mini.operators").setup({ -- Text edit operators{{{
--         replace = { prefix = "gP" },
--         -- evaluate = { prefix = "<leader>=" },
--         -- exchange = { prefix = "<leader>x" },
--         -- multiply = { prefix = "<leader>d" },
--         -- replace = { prefix = "<leader>r" },
--         -- sort = { prefix = "<leader>S" },
--     }) -- }}}
require("mini.pairs").setup() -- Autopairs
require("mini.pick").setup() -- Pick anything{{{
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
-- }}}
require("mini.sessions").setup() -- Session management{{{
local MiniSessions = MiniSessions
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

vim.keymap.set("n", "<leader>'", function()
    MiniSessions.select()
end, { desc = "Switch session" })
-- }}}
-- require("mini.snippets").setup({ -- Manage and expand snippets{{{
--     snippets = {
--         -- Load custom file with global snippets first (adjust for Windows)
--         require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),
--
--         -- Load snippets based on current language by reading files from
--         -- "snippets/" subdirectories from 'runtimepath' directories.
--         require("mini.snippets").gen_loader.from_lang(),
--     },
--     mappings = {
--         -- Expand snippet at cursor position. Created globally in Insert mode.
--         expand = "<C-n>",
--         jump_next = "<C-e>",
--         jump_prev = "<C-h>",
--     },
-- })
-- local snippets = require("mini.snippets")
-- local match_strict = function(snips)
--     -- Do not match with whitespace to cursor's left
--     return snippets.default_match(snips, { pattern_fuzzy = "%S+" })
-- end
-- local expand_or_jump = function()
--     local can_expand = #MiniSnippets.expand({ insert = false }) > 0
--     if can_expand then
--         vim.schedule(MiniSnippets.expand)
--         return ""
--     end
--     local is_active = MiniSnippets.session.get() ~= nil
--     if is_active then
--         MiniSnippets.session.jump("next")
--         return ""
--     end
--     return "\t"
-- end
-- local jump_prev = function()
--     MiniSnippets.session.jump("prev")
-- end
-- vim.keymap.set("i", "<Tab>", expand_or_jump, { expr = true })
-- vim.keymap.set("i", "<S-Tab>", jump_prev)
-- -- }}}
-- require("mini.splitjoin").setup() -- Split and join arguments
require("mini.starter").setup() -- Start screen
require("mini.statusline").setup() -- Statusline
require("mini.surround").setup() -- Surround actions
require("mini.tabline").setup() -- Tabline
-- require("mini.test").setup() -- Test Neovim plugins
-- require("mini.trailspace").setup() -- Trailspace (highlight and remove){{{
-- -- Delete trailing space on write
-- vim.api.nvim_create_autocmd("BufWritePre", { callback = MiniTrailspace.trim })
-- vim.api.nvim_create_autocmd("BufWritePre", { callback = MiniTrailspace.trim_last_lines })
-- -- }}}
require("mini.visits").setup() -- Track and reuse file system vislaim Control Number{{{
local function pick_visit_dir()
    local visits = require("mini.visits")
    local pick = require("mini.pick")
    pick.start({
        source = {
            name = "Visited directories",
            items = visits.list_paths({ sort = "last" }),
            format = function(path)
                -- show only the directory name
                return vim.fn.fnamemodify(path, ":t")
            end,
            choose = function(path)
                if not path then
                    return
                end
                vim.cmd.cd(path)
                vim.notify("cwd → " .. path)
            end,
        },
    })
end

vim.keymap.set("n", "<leader>vd", pick_visit_dir, { desc = "Pick visited dir" })
-- }}}
-- vim: fdm=marker fdl=0

local add = require("mini.deps").add
add("kdheepak/lazygit.nvim")

vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = "" -- custom config file path
-- OR
vim.g.lazygit_config_file_path = {} -- table of custom config file paths

vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)

-- Same binding I use in tmux
vim.keymap.set("n", "<C-t><C-y>", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

local lazygit = function()
    --  get file name with extension
    local file = vim.fn.expand("%:t")
    vim.cmd("LazyGit")

    -- Wait a bit for LazyGit to load
    vim.defer_fn(function()
        -- search for the file, highlight, and exit search mode in lazygit
        vim.api.nvim_feedkeys("/" .. file, "t", true)
        vim.api.nvim_input("<CR>")
        vim.api.nvim_input("<ESC>")
    end, 150) -- (milliseconds)
end
-- vim.keymap.set("n", "<leader>lg", lazygit, { desc = "LazyGit" })
-- vim.keymap.set("n", "<leader>gl", lazygit, { desc = "LazyGit" })

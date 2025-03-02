local PluginFiles = {
    "lsp",
    "cmp",
    "treesitter",
    -- 'null-ls',
    "mini",
    "colorschemes",
    -- "lazygit",
    'tmux',
}
local Plugins = {
    "nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
    -- "davidgranstrom/nvim-markdown-preview", -- https://github.com/davidgranstrom/nvim-markdown-preview
    "github/copilot.vim",
    "akinsho/toggleterm.nvim",           -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
}

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

for _, plugin in pairs(PluginFiles) do
    require("plugins/" .. plugin)
end

for _, repo in pairs(Plugins) do
    MiniDeps.add(repo)
end

require("toggleterm").setup({
    open_mapping = "<C-g>",
    direction = "horizontal",
    shade_terminals = true,
})

-- vim: fdl=1

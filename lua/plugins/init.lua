local PluginFiles = {
    "lsp",
    "cmp",
    "treesitter",
    'null-ls',
    "mini",
    "colorschemes",
    -- 'tmux',
    -- "lazygit",
}

local Plugins = {
    "folke/tokyonight.nvim",
    "ellisonleao/gruvbox.nvim",
    "github/copilot.vim",
    "akinsho/toggleterm.nvim",
    "alexghergh/nvim-tmux-navigation",
    "kdheepak/lazygit.nvim",
    -- "nvim-lua/plenary.nvim",

    { -- cmp
        source = "hrsh7th/nvim-cmp",
        depends = {
            "hrsh7th/cmp-nvim-lsp",
            "abeldekat/cmp-mini-snippets" },
    },

    { -- lsp
        source = "neovim/nvim-lspconfig",
        depends = {
            "rafamadriz/friendly-snippets",
            "olrtg/nvim-emmet",
        },
    },

    { -- mason
        source = "williamboman/mason.nvim",
        depends = {
            "williamboman/mason-lspconfig.nvim",
            -- "mhartington/formatter.nvim",
        },
    },

    { -- null-ls
        source = "nvimtools/none-ls.nvim",
        depends = {
            "jay-babu/mason-null-ls.nvim",
        },
    },

    { -- treesitter
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
        depends = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-context",
            'HiPhish/rainbow-delimiters.nvim',
        },
    },
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

for _, repo in pairs(Plugins) do
    require("mini.deps").add(repo)
end

for _, plugin in pairs(PluginFiles) do
    require("plugins/" .. plugin)
end

require("toggleterm").setup({
    open_mapping = "<C-g>",
    direction = "horizontal",
    shade_terminals = true,
})

require 'nvim-tmux-navigation'.setup {
    disable_when_zoomed = true,         -- defaults to false
    keybindings = {
        left        = "<C-h>",
        down        = "<C-n>",
        up          = "<C-e>",
        right       = "<C-i>",
        last_active = "<C-\\>",
        next        = "<C-Space>",
    }
}

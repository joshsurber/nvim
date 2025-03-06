for _, repo in pairs({
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
            "HiPhish/rainbow-delimiters.nvim",
        },
    },
}) do require("mini.deps").add(repo) end

for _, plugin in pairs({
    "lsp",
    "cmp",
    "treesitter",
    "null-ls",
    "mini",
    "colorschemes",
    "lazygit",
}) do require("plugins/" .. plugin) end

require("toggleterm").setup({
    open_mapping = "<C-g>",
    direction = "horizontal",
    shade_terminals = true,
})

require "nvim-tmux-navigation".setup({
    disable_when_zoomed = true, -- defaults to false
    keybindings = {
        left        = "<C-h>",
        down        = "<C-n>",
        up          = "<C-e>",
        right       = "<C-i>",
        last_active = "<C-\\>",
        next        = "<C-Space>",
    }
})

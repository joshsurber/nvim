local add = require("mini.deps").add
add('mini.nvim')
require("plugins.mini")

-- require("plugins.formatter")
-- require("plugins.null-ls")
-- require("plugins.toggleterm")

add("github/copilot.vim")

-- add("kdheepak/lazygit.nvim")
-- require("plugins.lazygit")

add("folke/tokyonight.nvim")
add("ellisonleao/gruvbox.nvim")
require("plugins.colorschemes")

add("williamboman/mason.nvim")
add("neovim/nvim-lspconfig")
add("williamboman/mason-lspconfig.nvim")
add("olrtg/nvim-emmet")
-- add("rafamadriz/friendly-snippets")

require("plugins.lsp")
add("alexghergh/nvim-tmux-navigation")
require("plugins.tmux")

add({ -- treesitter
    source = "nvim-treesitter/nvim-treesitter",
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    depends = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-context",
        "HiPhish/rainbow-delimiters.nvim",
    },
})
require("plugins.treesitter")

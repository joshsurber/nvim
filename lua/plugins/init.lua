local add = require("mini.deps").add

require("plugins/lsp")
-- require("plugins/cmp")
require("plugins/treesitter")
-- require("plugins/null-ls")
require("plugins/mini")
require("plugins/lazygit")
require("plugins/colorschemes")

add("github/copilot.vim")
add("kdheepak/lazygit.nvim")

--     shade_terminals = true,
-- add("akinsho/toggleterm.nvim")
-- require("toggleterm").setup({
--     open_mapping = "<C-g>",
--     direction = "horizontal",
-- })

add("alexghergh/nvim-tmux-navigation")
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

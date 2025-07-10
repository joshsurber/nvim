local add = require("mini.deps").add
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

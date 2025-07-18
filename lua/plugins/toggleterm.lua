local add = require("mini.deps").add
add("akinsho/toggleterm.nvim")
require("toggleterm").setup({
	shade_terminals = true,
	open_mapping = "<C-g>",
	direction = "horizontal",
})

local add = require("mini.deps").add
add("mini.nvim")
add("github/copilot.vim")

require("plugins.minnie")
require("plugins.colorschemes")
require("plugins.lsp")
require("plugins.tmux")
require("plugins.treesitter")
require("plugins.format")

-- require("plugins.toggleterm")
require("plugins.lazygit")

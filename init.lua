vim.g.mapleader = " "

require("user.which-key") -- Must be first as it exposes WKRegister function other files use
require("user.autocmds") -- Do stuff when stuff happens
require("user.colorscheme") -- Make things pretty
require("user.mappings") -- Key mappings
require("user.plugins") -- Packer install stuff
require("user.settings") -- Basic options
require("user.setup") -- For plugins that require more than a `use` but not a full file

--[[ Plugins that require configuration ]]
require("user.auto-session")
require("user.bufferline")
require("user.emmet")
require("user.gitsigns")
require("user.indent-blankline")
require("user.lsp-zero")
require("user.null-ls")
require("user.lualine")
require("user.telescope")
require("user.toggleterm")
require("user.treesitter")

-- Neovide config
vim.o.guifont = "CascadiaCode_Nerd_Font,Cascadia_Code_PL,Hack:h10"
vim.cmd([[
let g:neovide_floating_blur_amount_x = 50
let g:neovide_floating_blur_amount_y = 50
let g:neovide_cursor_vfx_mode = "railgun"
]])

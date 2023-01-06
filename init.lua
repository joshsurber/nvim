vim.g.mapleader = " "

require("user.which-key") -- Must be first as it exposes WKRegister function other files use
require("user.autocmds") -- Do stuff when stuff happens
-- require("user.colorscheme") -- Make things pretty
require("user.mappings") -- Key mappings
require("user.plugins") -- Packer install stuff
require("user.settings") -- Basic options

--[[ Plugins that require configuration ]]
-- require("user.auto-session")
-- require("user.bufferline")
-- require("user.emmet")
-- require("user.gitsigns")
-- require("user.indent-blankline")
-- require("user.lsp-zero")
-- require("user.lualine")
-- require("user.null-ls")
-- require("user.telescope")
-- require("user.textobjects")
-- require("user.toggleterm")
-- require("user.treesitter")

-- For plugins that require more than a `use` but not a full file
for _, plugin in pairs({
    'nvim-autopairs',
    'nvim-surround',
    'Comment',
}) do
    local ok, result = pcall(require, plugin)
    if not ok then return vim.notify(plugin .. ' not loaded') end
    pcall(result.setup)
    -- vim.notify(plugin .. ' loaded')
end

-- vim: foldlevel=2

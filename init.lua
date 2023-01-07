vim.g.mapleader = " "

require("user.autocmds") -- Do stuff when stuff happens
require("user.mappings") -- Key mappings
require("user.plugins") -- Packer install stuff
require("user.settings") -- Basic options

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

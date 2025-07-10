local add = require("mini.deps").add
add("mhartington/formatter.nvim")
local util = require "formatter.util"
require("formatter").setup {
    lua = {
        require("formatter.filetypes.lua").stylua,

        function()
            return {
                exe = "stylua",
                args = {
                    "--search-parent-directories",
                    "--stdin-filepath",
                    util.escape_path(util.get_current_buffer_file_path()),
                    "--",
                    "-",
                },
                stdin = true,
            }
        end
    },
}

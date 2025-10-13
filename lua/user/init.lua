require("user.set")
require("user.map")
require("user.colemak")
require("user.autocmds")

vim.api.nvim_create_user_command("Bonly", function()
    -- vim.cmd([[%bdelete|edit #|silent normal ` "]])
    vim.cmd([[%bdelete|edit #]])
end, {})

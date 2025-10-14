vim.api.nvim_create_user_command("Bonly", function()
    -- vim.cmd([[%bdelete|edit #|normal ` ']])
    vim.cmd([[%bdelete|edit #]])
end, {})

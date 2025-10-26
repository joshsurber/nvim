-- Change CWD to current file's directory
vim.api.nvim_create_user_command("CD", function()
    vim.cmd.cd(vim.fn.expand("%:h"))
end, {})

vim.api.nvim_create_user_command("Bonly", function()
    -- vim.cmd([[%bdelete|edit #|normal ` ']])
    vim.cmd([[%bdelete|edit #]])
end, {})

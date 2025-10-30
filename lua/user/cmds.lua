-- Change CWD to current file's directory
vim.api.nvim_create_user_command("CD", function()
    vim.cmd.cd(vim.fn.expand("%:h"))
end, {})

vim.api.nvim_create_user_command("Bonly", function()
    -- This is the version i found, but it errored
    -- vim.cmd([[%bdelete|edit #|normal ` ']])

    -- This works but leaves an empty tab when used with mini.tabline
    -- vim.cmd([[%bdelete|edit #]])

    -- This works with mini.tabline
    vim.cmd([[%bdelete|edit #|bnext|bwipeout]])
end, {})

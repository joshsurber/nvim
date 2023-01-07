for _, mod in pairs({
    'ai',
    'animate',
    'bufremove',
    'comment',
    'cursorword',
    'pairs',
    'sessions',
    -- 'starter',
    'statusline',
    'surround',
    'tabline',
    'trailspace',
}) do
    require('mini.' .. mod).setup()
end

require('mini.sessions').setup({
    autoread = true,
})

-- vim.api.nvim_create_user_command('Bdelete', )

for _, module in pairs({

    'ai', -- Extend and create `a`/`i` textobjects              https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    -- 'align', -- Align text interactively                        https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
    'animate', -- Animate common Neovim actions                 https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md
    -- 'base16', -- Base16 colorscheme creation                    https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-base16.md
    'bufremove', -- Remove buffers                              https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
    'comment', -- Comment                                       https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
    -- 'completion', -- Completion and signature help              https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-completion.md
    'cursorword', -- Autohighlight word under cursor            https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
    -- 'doc', -- Generate Neovim help files                        https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-doc.md
    -- 'fuzzy', -- Fuzzy matching                                  https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-fuzzy.md
    'indentscope', -- Visualize and operate on indent scope     https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
    -- 'jump', -- Jump forward/backward to a single character      https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump.md
    -- 'jump2d', -- Jump within visible lines                      https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump2d.md
    -- 'map', -- Window with buffer text overview                  https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md
    -- 'misc', -- Miscellaneous functions                          https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-misc.md
    'pairs', -- Autopairs                                       https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
    'sessions', -- Session management                           https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-sessions.md
    'starter', -- Start screen                                  https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
    'statusline', -- Statusline                                 https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md
    'surround', -- Surround actions                             https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
    'tabline', -- Tabline                                       https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
    -- 'test', -- Test Neovim plugins                              https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-test.md
    'trailspace', -- Trailspace (highlight and remove)          https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md

}) do
    require('mini.' .. module).setup()
end

require('mini.sessions').setup({
    autoread = true,
})

-- vim.api.nvim_create_user_command('Bdelete', )

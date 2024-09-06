return {
    -- 'nvim-tree/nvim-web-devicons', -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-lua/plenary.nvim', -- https://github.com/nvim-lua/plenary.nvim

    -- 'mbbill/undotree', -- https://github.com/mbbill/undotree
    'tpope/vim-eunuch', -- Unix utilities -- https://github.com/tpope/vim-eunuch
    -- 'tpope/vim-repeat', -- Do it again -- https://github.com/tpope/vim-repeat
    -- 'vifm/vifm.vim',

    'davidgranstrom/nvim-markdown-preview', -- https://github.com/davidgranstrom/nvim-markdown-preview
    -- 'hail2u/vim-css3-syntax', -- The newest hawtness of CSS -- https://github.com/hail2u/vim-css3-syntax
    'tpope/vim-liquid', -- Support for liquid templates -- https://github.com/tpope/vim-liquid

    -- Popup tree of available key mappings }
    -- { 'folke/which-key.nvim', config = true },
    { 'akinsho/toggleterm.nvim', -- Easy terminal access -- https://github.com/akinsho/toggleterm.nvim
        opts = {
            open_mapping = '<C-g>',
            direction = 'horizontal',
            shade_terminals = true
        }
    }
}
-- vim: fdl=1

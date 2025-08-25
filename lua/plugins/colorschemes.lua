local add = require("mini.deps").add

-- add("ellisonleao/gruvbox.nvim")-- {{{
-- vim.cmd.colorscheme("gruvbox")-- }}}
add("folke/tokyonight.nvim") -- {{{
require("tokyonight").setup({
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    dim_inactive = true, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})
vim.cmd.colorscheme("tokyonight") -- }}}
-- add("rose-pine/neovim") -- {{{
-- require("rose-pine").setup({
--     variant = "auto", -- auto, main, moon, or dawn
--     dark_variant = "main", -- main, moon, or dawn
--     dim_inactive_windows = true,
--     extend_background_behind_borders = true,
--
--     styles = {
--         bold = true,
--         italic = true,
--         transparency = true,
--     },
--
--     highlight_groups = {
--         -- Comment = { fg = "foam" },
--         -- StatusLine = { fg = "love", bg = "love", blend = 15 },
--         -- VertSplit = { fg = "muted", bg = "muted" },
--         -- Visual = { fg = "base", bg = "text", inherit = false },
--     },
--
--     before_highlight = function(group, highlight, palette)
--         -- Disable all undercurls
--         -- if highlight.undercurl then
--         --     highlight.undercurl = false
--         -- end
--         --
--         -- Change palette colour
--         -- if highlight.fg == palette.pine then
--         --     highlight.fg = palette.foam
--         -- end
--     end,
-- })
-- vim.cmd.colorscheme("rose-pine") -- }}}

-- vim: fdm=marker fdl=0

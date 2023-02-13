return {
    { 'folke/tokyonight.nvim', opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
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
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    } }, -- https://github.com/folke/tokyonight.nvim
    { 'ellisonleao/gruvbox.nvim' }, -- https://github.com/ellisonleao/gruvbox.nvim
    { 'ishan9299/nvim-solarized-lua' },
    { 'rose-pine/neovim', name = 'rose-pine', opts = {
        --- @usage 'main' | 'moon'
        dark_variant = 'main',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = true,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
            background = 'base',
            panel = 'surface',
            border = 'highlight_med',
            comment = 'muted',
            link = 'iris',
            punctuation = 'subtle',

            error = 'love',
            hint = 'iris',
            info = 'foam',
            warn = 'gold',

            headings = {
                h1 = 'iris',
                h2 = 'foam',
                h3 = 'rose',
                h4 = 'gold',
                h5 = 'pine',
                h6 = 'foam',
            }
            -- or set all headings at once
            -- headings = 'subtle'
        },

        -- Change specific vim highlight groups
        highlight_groups = {
            ColorColumn = { bg = 'rose' }
        }
    } },
    { 'ray-x/starry.nvim', config = function()
        for key, value in pairs({
            borders = false,
            contrast = true,
            darker_contrast = true, --"darker background
            daylight_switch = false, --"this allow using brighter color
            deep_black = true, --"OLED deep black
            disable_background = true, --"set to true to disable background and allow transparent background
            italic_comments = true,
            italic_functions = false,
            italic_keywords = false,
            italic_string = false,
            italic_variables = false,
            style = "moonlight", --"load moonlight everytime or
            style_fix = true, --"disable random loading
            set_hl = true, --" Note: enable for nvim 0.6+, it is faster (loading time down to 4~6s from 7~11s), but it does not overwrite old values and may has some side effects
        }) do vim.g['starry_' .. key] = value end
    end }, -- https://github.com/ray-x/starry.nvim
}
-- vim: fdl=1

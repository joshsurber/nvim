--" If we haven't installed gruvbox yet, use a build-in colorscheme
    -- vim.o.background = "dark" -- or "light" for light mode
    vim.cmd.colorscheme("evening")
    local colorscheme = 'tokyonight' -- tokyonight gruvbox dracula dracula_blood monokai

for --[[STARRY SETUP]]key, value in pairs({
    italic_comments = true,
    italic_string = false,
    italic_keywords = false,
    italic_functions = false,
    italic_variables = false,
    contrast = true,
    borders = false,
    disable_background = false, --"set to true to disable background and allow transparent background
    style_fix = true, --"disable random loading
    style = "moonlight", --"load moonlight everytime or
    darker_contrast = true, --"darker background
    deep_black = true, --"OLED deep black
    italic_keywords = false,
    italic_functions = false,
    set_hl = false, --" Note: enable for nvim 0.6+, it is faster (loading time down to 4~6s from 7~11s), but it does
    --" not overwrite old values and may has some side effects
    daylight_switch = false, --"this allow using brighter color
    --" other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
}) do vim.g['starry_' .. key] = value end

require("tokyonight").setup({
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
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
})

vim.cmd.colorscheme(colorscheme)

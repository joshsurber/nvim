-- lua/windows.lua

-- Disable Tree-sitter by default (opt-in later)
pcall(function()
    require("nvim-treesitter.configs").setup({
        highlight = { enable = false },
        indent = { enable = false },
    })
end)

-- Performance knobs
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 500
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.maxmempattern = 2000

-- Avoid slow providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Windows path weirdness
vim.opt.shell = "cmd.exe"
vim.opt.shellcmdflag = "/c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- Bypass Scoop shim if launching Neovim manually
vim.env.PATH = vim.fn.expand("$USERPROFILE") .. "\\scoop\\apps\\neovim\\current\\bin;" .. vim.env.PATH

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "lua", "yaml" },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

local pick = require("mini.pick")

local dirs = {
    {
        name = "Espanso",
        path = "~/OneDrive - Office Ally Inc/Apps/Espanso-Win-Portable-x86_64/espanso-portable/.espanso/match",
    },
    { name = "OAWA", path = "~/OneDrive - Office Ally Inc/Documents/OAWA" },
    { name = "Downloads", path = "~/Downloads" },
    { name = "nvim", path = "~/AppData/Local/nvim/" },
}

-- local function pick_cwd()
--     pick.start({
--         source = {
--             items = dirs,
--             name = "Change directory",
--             choose = function(item)
--                 if not item then
--                     return
--                 end
--                 vim.cmd.cd(vim.fn.expand(item.path))
--                 vim.notify("cwd → " .. vim.fn.getcwd())
--             end,
--         },
--     })
-- end

local function pick_cwd()
    pick.start({
        source = {
            name = "Change directory",
            items = dirs,
            format = function(item)
                -- expand ~ and get only the directory name
                return item.name
            end,
            choose = function(item)
                if not item then
                    return
                end
                vim.cmd.cd(vim.fn.expand(item.path))
            end,
        },
    })
end

-- Optional keymap
vim.keymap.set("n", "<leader>cd", pick_cwd, { desc = "Pick cwd" })

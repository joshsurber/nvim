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

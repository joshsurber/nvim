local ok, whichkey = pcall(require, 'which-key')
if not ok then return vim.notify('whichkey not loaded') end
whichkey.setup({
    plugins = {
        spelling = {
            enabled = true
        }
    }
})

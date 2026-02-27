-- ftdetect/x12.lua
vim.filetype.add({
    extension = {
        edi = "x12",
        x12 = "x12",
    },
    filename = {
        ["X12_*.txt"] = "x12",
    },
    pattern = {
        [".*"] = function(_, bufnr)
            local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
            -- if #line >= 106 and line:sub(1, 3) == "ISA" then
            if line:match("^ISA") then
                return "x12"
            end
        end,
    },
})

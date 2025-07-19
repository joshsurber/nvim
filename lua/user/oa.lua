vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "time"
vim.g.netrw_sort_direction = "reverse"

vim.filetype.add({
	filename = {
		[".x12"] = "x12",
		[".835"] = "x12",
		[".837"] = "x12",
		[".837p"] = "x12",
		[".837i"] = "x12",
		[".837d"] = "x12",
		[".277"] = "x12",
		[".999"] = "x12",
	},
	pattern = {
		[".*/Downloads/.*"] = "x12",
	},
})

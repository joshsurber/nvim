--[[
-- I don't see a reason to create an entire file for the plugins that can be setup with one function call. Lets make it simpler!
--
-- Also, I think this is my first from-scratch Lua file with no yank/put! Worked first try :-)
--]]

local function setup(plugin)
	local ok, result = pcall(require, plugin)
	if not ok then return vim.notify(plugin .. ' not loaded') end
	result.setup()
	-- vim.notify(plugin .. ' loaded')
end

local plugins = {
	'nvim-ts-autotag',
	'nvim-autopairs',
	'nvim-surround',
	'Comment',
	'neoscroll',
	-- 'hl_match_area',
}

for _, plugin in pairs(plugins) do
	setup(plugin)
end

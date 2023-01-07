local leader = '\\'

-- Emmet has an old-school global variable based config approach. Let's lua-ize it, shall we?

for _, mapping in pairs({
	-- leader_key = leader,
	{ key = '', cmd = 'leader_key', desc = 'Emmet' },
	{ key = '\\', cmd = 'expandabbr_key', desc = 'Expand abbreviation' },
	{ key = ';', cmd = 'expandword_key', desc = 'Expand abbreviation, skipping HTML' },
	{ key = 'u', cmd = 'update_tag', desc = 'Change current tag' },
	{ key = 'd', cmd = 'balancetaginward_key', desc = 'Select inner tag' },
	{ key = 'D', cmd = 'balancetagoutward_key', desc = 'Select outer tag' },
	{ key = 'n', cmd = 'next_key', desc = 'Goto next edit point' },
	{ key = 'N', cmd = 'prev_key', desc = 'Goto previous edit point' },
	{ key = 'i', cmd = 'imagesize_key', desc = 'Add or update image size' },
	{ key = '/', cmd = 'togglecomment_key', desc = 'Comment/uncomment a block' },
	{ key = 'j', cmd = 'splitjointag_key', desc = 'Split or join a tag' },
	{ key = 'k', cmd = 'removetag_key', desc = 'Remove a tag' },
	{ key = 'a', cmd = 'anchorizeurl_key', desc = 'Make anchor from URL' },
	{ key = 'A', cmd = 'anchorizesummary_key', desc = 'Get quote from URL' },
	{ key = 'm', cmd = 'mergelines_key', desc = 'Merge lines' },
	{ key = 'c', cmd = 'codepretty_key', desc = 'Code pretty' },
}) do
	vim.g['user_emmet_' .. mapping.cmd] = leader .. mapping.key
end

for key, value in pairs({ -- globals (for older plugins)
	html5 = 1,
	docroot = {},
	curl_command = 'curl -s -L -A Mozilla/5.0',
	complete_tag = 'setlocal omnifunc=emmet#completeTag',
	install_global = 1,
	install_command = 1,
	settings = {
		variables = {
			lang = 'en',
		},
		indentation = ' ',
		html = {
			filters = 'html',
			indentation = ' ',
			quote_char = '"',
			expandos = {
				ol = 'ol>li',
				list = 'ul>li*3',
			},
			default_attributes = {
				a = { href = 'foo' },
				link = {
					{ rel = 'stylesheet' },
					{ href = 'foobar' }
				},
			},
			aliases = {
				bq = 'blockquote',
				obj = 'object',
				src = 'source',
			},
			empty_elements = 'area,base,basefont,...,isindex,link,meta,...',
			block_elements = 'address,applet,blockquote,...,li,link,map,...',
			inline_elements = 'a,abbr,acronym,...',
			empty_element_suffix = ' />',
		},
		php = {
			extends = 'html',
			filters = 'html,c',
		},
		css = {
			filters = 'fc',
		},
		javascript = {
			snippets = {
				fn = [[
				(function() {
					${cursor}
					})();
				]],
			},
		},
	},
	mode = 'a', --n=normal i=insert v=visual a=all
}) do
	vim.g['emmet_' .. key] = value
	vim.g['user_emmet_' .. key] = value
end
-- vim: foldlevel=2

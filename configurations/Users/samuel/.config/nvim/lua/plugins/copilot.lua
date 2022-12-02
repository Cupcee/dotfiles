local keymap_suggestion = {
	accept = "<C-a>",
	next = "<C-n>",
	prev = "<C-N>",
	dismiss = "<C-d>",
}
local keymap = {
	jump_prev = "(",
	jump_next = ")",
	accept = "<CR>",
	refresh = "gr",
	open = "<C-p>",
}

if vim.g.neovide then
	keymap_suggestion = {
		accept = "<D-a>",
		next = "<D-n>",
		prev = "<D-N>",
		dismiss = "<D-d>",
	}
	keymap = {
		jump_prev = "(",
		jump_next = ")",
		accept = "<CR>",
		refresh = "gr",
		open = "<D-p>",
	}
end

require("copilot").setup({
	panel = {
		enabled = true,
		auto_refresh = false,
		keymap = keymap,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = keymap_suggestion,
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node version must be < 18
	plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
	server_opts_overrides = {},
})

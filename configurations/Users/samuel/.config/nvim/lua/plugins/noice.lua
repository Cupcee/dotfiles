require("noice").setup({
	cmdline = {
		view = "cmdline",
	},
	lsp = {
		progress = {
			enabled = false,
		},
	},
	messages = {
		view_warn = false,
	},
	routes = {
		{
			view = "mini",
			filter = { event = "msg_showmode" },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "less",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "more",
			},
			opts = { skip = true },
		},
	},
})

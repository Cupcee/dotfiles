require("noice").setup({
	cmdline = {
		view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	},
	lsp = {
		progress = {
			enabled = false,
		},
	},
	routes = {
		{
			view = "notify",
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

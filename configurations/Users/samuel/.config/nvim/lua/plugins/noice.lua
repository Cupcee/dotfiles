require("noice").setup({
	cmdline = {
		view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	},
	routes = {
		{
			view = "notify",
			filter = { event = "msg_showmode" },
		},
	},
})

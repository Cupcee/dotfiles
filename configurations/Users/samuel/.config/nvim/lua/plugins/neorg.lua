require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {
			config = {
				icon_preset = "diamond",
				folds = false,
			},
		},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
				},
			},
		},
	},
})

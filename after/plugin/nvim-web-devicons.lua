local nwd = require("nvim-web-devicons")

nwd.setup({
	override_by_extension = {
		["pym"] = {
			icon = "",
			color = "#ffbc03",
			cterm_color = "214",
			name = "Pym",
		},
	},
})

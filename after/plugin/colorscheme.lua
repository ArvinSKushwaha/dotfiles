require("catppuccin").setup({
	flavor = "mocha",
	-- transparent_background = true,
	custom_highlights = function(colors)
		return {
			Comment = { fg = colors.overlay0 },
			DiagnosticUnnecessary = { fg = colors.overlay0 },
			-- TabLineSel = { bg = colors.pink },
		}
	end,
    integrations = {
        fidget = true,
        hop = true,
    }
})

vim.cmd.colorscheme("catppuccin")

local ctp_feline = require("catppuccin.groups.integrations.feline")

ctp_feline.setup({})

require("feline").setup({
	components = ctp_feline.get({}),
})

require("feline").winbar.setup({})

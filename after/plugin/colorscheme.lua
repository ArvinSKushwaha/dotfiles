require("catppuccin").setup({
	flavor = "mocha",
	-- transparent_background = true,
	custom_highlights = function(colors)
		return {
			-- Comment = { fg = colors.flamingo },
			-- TabLineSel = { bg = colors.pink },
		}
	end,
})

vim.cmd.colorscheme("catppuccin")

local ctp_feline = require("catppuccin.groups.integrations.feline")

ctp_feline.setup({})

require("feline").setup({
	components = ctp_feline.get({}),
})

require("feline").winbar.setup({})

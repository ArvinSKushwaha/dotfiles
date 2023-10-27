local vimtex_options = {
	tex_flavor = "latex",
	matchup_override_vimtex = 0,
	vimtex_view_method = "zathura",
	vimtex_compiler_method = "latexmk",
    vimtex_fold_enabled = 1,
    vimtex_env_toggle_math_map = {
        ["\\("] = "\\[",
        ["\\["] = "equation",
        ["equation"] = "\\(",
    },
	vimtex_quickfix_mode = 0,
	vimtex_imaps_enabled = 0,
	vimtex_parser_bib_backend = "bibtexparser",
	vimtex_syntax_conceal = {
		spacing = 0,
	},
	vimtex_indent_on_ampersands = 0,
	vimtex_delim_list = {
		delim_math = {
			name = {
				{ "(", ")" },
				{ "[", "]" },
				{ [[\{]], [[\}]] },
				{ [[\|]], [[\|]] },
				{ [[\langle]], [[\rangle]] },
				{ [[\lparen]], [[\rparen]] },
				{ [[\lbrace]], [[\rbrace]] },
				{ [[\lvert]], [[\rvert]] },
				{ [[\lVert]], [[\rVert]] },
				{ [[\lfloor]], [[\rfloor]] },
				{ [[\lceil]], [[\rceil]] },
				{ [[\ulcorner]], [[\urcorner]] },
				{ [[\llcorner]], [[\lrcorner]] },
			},
		},
	},
}

for op, val in pairs(vimtex_options) do
	vim.g[op] = val
end

local map = vim.keymap.set

map({ "o", "x" }, "ai", "<Plug>(vimtex-am)", {})
map({ "o", "x" }, "ii", "<Plug>(vimtex-im)", {})
map({ "o", "x" }, "am", "<Plug>(vimtex-a$)", {})
map({ "o", "x" }, "im", "<Plug>(vimtex-i$)", {})

map("n", "dsm", "<Plug>(vimtex-env-delete-math)", {})
map("n", "csm", "<Plug>(vimtex-env-change-math)", {})
map("n", "tsm", "<Plug>(vimtex-env-toggle-math)", {})

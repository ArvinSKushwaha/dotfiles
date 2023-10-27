local helpers = require("luasnip-helpers")

return {
	s(
		{ trig = ";;", snippetType = "autosnippet", wordTrig = false },
		fmta("<>", { t(" \\, ") }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fd", snippetType = "autosnippet" },
		fmta("\\underline{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "ft", snippetType = "autosnippet" },
		fmta("\\textit{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "fb", snippetType = "autosnippet" },
		fmta("\\textbf{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "st", snippetType = "autosnippet" },
		fmta("\\text{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fr", snippetType = "autosnippet" },
		fmta("\\mathrm{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fb", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bm{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fc", snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathcal{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fB", snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathbb{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\0-9A-Za-z_]+)'sc", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathcal{<>}", {
			f(function(args, parents, user_args)
				return parents.captures[1]
			end, {}, {}),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\0-9A-Za-z_]+)'sb", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\bm{<>}", {
			f(function(args, parents, user_args)
				return parents.captures[1]
			end, {}, {}),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\0-9A-Za-z_]+)'sB", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathbb{<>}", {
			f(function(args, parents, user_args)
				return parents.captures[1]
			end, {}, {}),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "un", snippetType = "autosnippet" },
		fmta("\\SI{<>}{<>}", { d(1, helpers.get_visual), i(2) }),
		{ condition = helpers.in_mathzone }
	),
	s({ trig = "--", snippetType = "autosnippet" }, fmta("\\item <> ", { d(1, helpers.get_visual) }), {
		condition = (helpers.in_itemize + helpers.in_env("enumerate")) * conds_expand.line_begin,
	}),
	s(
		{ trig = "(%s)'([123])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>", {
			d(1, function(args, parents, user_args)
				local idx = tonumber(parents.captures[2])
				local table = {
					"\\dot",
					"\\ddot",
					"\\dddot",
				}

				if table[idx] then
					return sn(nil, fmta(parents.captures[1] .. table[idx] .. "{<>}", { i(1) }))
				else
					return sn(nil, { t(parents.captures[1]) })
				end
			end),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)'([123])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>", {
			d(1, function(args, parents, user_args)
				local idx = tonumber(parents.captures[2])
				local table = {
					"\\dot",
					"\\ddot",
					"\\dddot",
				}

				if table[idx] then
					return sn(nil, fmta(table[idx] .. "{<>}", { t(parents.captures[1]) }))
				else
					return sn(nil, { t(parents.captures[1]) })
				end
			end),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(args, parents, user_args)
				return parents.captures[1]
			end, {}, {}),
			d(1, function(args, parents, user_args)
				return sn(nil, fmta(parents.captures[2] .. "<>", { i(1) }))
			end),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ",r", snippetType = "autosnippet", wordTrig = false },
		fmta("_{<>}", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ",s", snippetType = "autosnippet", wordTrig = false },
		fmta("^{<>}", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ";r", snippetType = "autosnippet", wordTrig = false },
		fmta("\\sqrt{<>}", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ";f", snippetType = "autosnippet", wordTrig = false },
		fmta([[\frac{<>}{<>}]], { i(1), i(2) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "dnt", snippetType = "autosnippet" },
		fmta([[\int<> <> \odif{<>}]], { i(2), i(1), i(3, "x") }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'ls", snippetType = "autosnippet", wordTrig = false },
		fmta([[\limits_{<>}^{<>} ]], { i(1), i(2) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([A-Za-z0-9]?)'df", regTrig = true, snippetType = "autosnippet" },
		fmta("\\odv<>{<>}{<>}", {
			f(function(args, parents, user_args)
				if #parents.captures[1] > 0 then
					return "[ord=" .. parents.captures[1] .. "]"
				else
					return ""
				end
			end),
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([A-Za-z0-9]?)'pf", regTrig = true, snippetType = "autosnippet" },
		fmta("\\pdv<>{<>}{<>}", {
			f(function(args, parents, user_args)
				if #parents.captures[1] > 0 then
					return "[ord=" .. parents.captures[1] .. "]"
				else
					return ""
				end
			end),
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)vec", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\vec{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}]+)'vc", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\vec{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)hat", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\hat{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}]+)'ht", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\hat{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)bar", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\overline{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}]+)'br", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\overline{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "mpt", snippetType = "autosnippet" },
		fmta("\\mappingto{<>}{<>}{<>}", { i(1), i(2), i(3) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "mpg", snippetType = "autosnippet" },
		fmta("\\mapping{<>}{<>}{<>}", { i(1), i(2), i(3) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ' "', snippetType = "autosnippet", wordTrig = false },
		fmta("<>``<>''", { t(" "), i(1) }),
		{ condition = helpers.in_text }
	),
}

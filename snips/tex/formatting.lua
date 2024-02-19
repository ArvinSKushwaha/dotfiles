local helpers = require("luasnip-helpers")

return {
	s(
		{ trig = ";;", snippetType = "autosnippet", wordTrig = false },
		fmta("<>", { t(" \\, ") }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ".rs", snippetType = "autosnippet", wordTrig = false },
		fmta("<>\\) <> \\(<>", { t(" "), i(1), t(" ") }),
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
		{ trig = "fm", snippetType = "autosnippet" },
		fmta("\\mathrm{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fb", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bm{<>}", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "fr", snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathfrak{<>}", { d(1, helpers.get_visual) }),
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
		{ trig = "([\\0-9A-Za-z_]+)'sr", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\mathfrak{<>}", {
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
		{ trig = "'un", snippetType = "autosnippet" },
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
		fmta([[\int<> <> \dd{<>}]], { i(2), i(1), i(3, "x") }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'ls", snippetType = "autosnippet", wordTrig = false },
		fmta([[\limits_{<>}^{<>} ]], { i(1), i(2) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([A-Za-z0-9]?)'dx", regTrig = true, snippetType = "autosnippet" },
		fmta("\\dv<>{<>}{<>}", {
			f(function(args, parents, user_args)
				if #parents.captures[1] > 0 then
					return "[" .. parents.captures[1] .. "]"
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
		{ trig = "([A-Za-z0-9]?)'px", regTrig = true, snippetType = "autosnippet" },
		fmta("\\pdv<>{<>}{<>}", {
			f(function(args, parents, user_args)
				if #parents.captures[1] > 0 then
					return "[" .. parents.captures[1] .. "]"
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
		{ trig = "([A-Za-z0-9]?)'fx", regTrig = true, snippetType = "autosnippet" },
		fmta("\\fdv<>{<>}{<>}", {
			f(function(args, parents, user_args)
				if #parents.captures[1] > 0 then
					return "[" .. parents.captures[1] .. "]"
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
		{ trig = "([\\A-Za-z0-9]+)vec", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\vec{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}0-9']+)'vc", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\vec{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z0-9']+)hat", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\hat{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}0-9']+)'ht", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\hat{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z0-9']+)bar", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\bar{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}0-9']+)'br", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\bar{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z0-9']+)ovr", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\overline{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}0-9']+)'vr", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\overline{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z0-9']+)tld", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\tilde{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}0-9']+)'tld", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\tilde{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)dif", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\dd{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}']+)'df", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\dd{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z]+)pif", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\ptl{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}']+)'pf", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\ptl{<>}", { f(function(args, parents, user_args)
			return parents.captures[1]
		end) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "([\\A-Za-z{}']+)'ev", regTrig = true, snippetType = "autosnippet", wordTrig = false },
		fmta("\\eval{<>}", { f(function(args, parents, user_args)
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
		{ trig = "'xp", snippetType = "autosnippet", wordTrig = false },
		fmta("\\expval{<>}", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ' "', snippetType = "autosnippet", wordTrig = false },
		fmta("<>``<>''", { t(" "), i(1) }),
		{ condition = helpers.in_text }
	),
	s({ trig = "qq", snippetType = "autosnippet" }, fmta("\\quad", {}), { condition = helpers.in_mathzone }),
	s({ trig = "QQ", snippetType = "autosnippet" }, fmta("\\qquad", {}), { condition = helpers.in_mathzone }),
}

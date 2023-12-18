local helpers = require("luasnip-helpers")

return {
	s(
		{ trig = "+-", snippetType = "autosnippet", wordTrig = false },
		fmta("\\pm ", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "-+", snippetType = "autosnippet", wordTrig = false },
		fmta("\\mp ", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "|->", snippetType = "autosnippet", wordTrig = false },
		fmta("\\mapsto", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "->", snippetType = "autosnippet", wordTrig = false },
		fmta("\\rightarrow", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'up", snippetType = "autosnippet", wordTrig = false },
		fmta("\\uparrow", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'dn", snippetType = "autosnippet", wordTrig = false },
		fmta("\\downarrow", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "<-", snippetType = "autosnippet", wordTrig = false },
		fmta("\\leftarrow", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "=>", snippetType = "autosnippet", wordTrig = false },
		fmta("\\implies", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "=<", snippetType = "autosnippet", wordTrig = false },
		fmta("\\impliedby", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'if", snippetType = "autosnippet" },
		fmta("\\Longleftrightarrow", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "==", snippetType = "autosnippet", wordTrig = false },
		fmta("\\equiv", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ":=", snippetType = "autosnippet", wordTrig = false },
		fmta("\\coloneq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "<=", snippetType = "autosnippet", wordTrig = false },
		fmta("\\le", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ">=", snippetType = "autosnippet", wordTrig = false },
		fmta("\\ge", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "<<", snippetType = "autosnippet", wordTrig = false },
		fmta("\\ll", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = ">>", snippetType = "autosnippet", wordTrig = false },
		fmta("\\gg", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "!=", snippetType = "autosnippet", wordTrig = false },
		fmta("\\neq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'sum", snippetType = "autosnippet", wordTrig = false },
		fmta("\\sum", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'xp", snippetType = "autosnippet", wordTrig = false },
		fmta("\\exp", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'prod", snippetType = "autosnippet", wordTrig = false },
		fmta("\\prod", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'int", snippetType = "autosnippet", wordTrig = false },
		fmta("\\int", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'ti", snippetType = "autosnippet", wordTrig = false },
		fmta("\\times", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'oti", snippetType = "autosnippet", wordTrig = false },
		fmta("\\otimes", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'opl", snippetType = "autosnippet", wordTrig = false },
		fmta("\\oplus", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'bti", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bigotimes", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'bpl", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bigoplus", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'ne", snippetType = "autosnippet", wordTrig = false },
		fmta("\\neg", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'we", snippetType = "autosnippet", wordTrig = false },
		fmta("\\wedge", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'ve", snippetType = "autosnippet", wordTrig = false },
		fmta("\\vee", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'bwe", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bigwedge", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "'bve", snippetType = "autosnippet", wordTrig = false },
		fmta("\\bigvee", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gis", snippetType = "autosnippet", wordTrig = true },
		fmta("\\subseteq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "giS", snippetType = "autosnippet", wordTrig = true },
		fmta("\\supseteq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gns", snippetType = "autosnippet", wordTrig = true },
		fmta("\\subsetneq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gnS", snippetType = "autosnippet", wordTrig = true },
		fmta("\\supsetneq", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gin", snippetType = "autosnippet", wordTrig = true },
		fmta("\\in", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gnn", snippetType = "autosnippet", wordTrig = true },
		fmta("\\not\\in", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "gic", snippetType = "autosnippet", wordTrig = true },
		fmta("\\cap", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "giC", snippetType = "autosnippet", wordTrig = true },
		fmta("\\bigcap", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "giu", snippetType = "autosnippet", wordTrig = true },
		fmta("\\cup", {}),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "giU", snippetType = "autosnippet", wordTrig = true },
		fmta("\\bigcup", {}),
		{ condition = helpers.in_mathzone }
	),
}

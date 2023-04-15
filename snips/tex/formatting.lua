local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

local line_begin = require('luasnip.extras.expand_conditions').line_begin
local helpers = require('luasnip-helpers')

return {
    s(
        { trig = "'a", snippetType="autosnippet" },
        fmta("\\alpha", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'b", snippetType="autosnippet" },
        fmta(" \\beta ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'g", snippetType="autosnippet" },
        fmta(" \\gamma ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'r", snippetType="autosnippet" },
        fmta(" \\rho ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'o", snippetType="autosnippet" },
        fmta(" \\omega ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'l", snippetType="autosnippet" },
        fmta(" \\lambda ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "->", snippetType="autosnippet" },
        fmta(" \\rightarrow ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "-<>", snippetType="autosnippet" },
        fmta(" \\leftrightarrow ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "<-", snippetType="autosnippet" },
        fmta(" \\leftarrow ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "=>", snippetType="autosnippet" },
        fmta(" \\implies ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "<=", snippetType="autosnippet" },
        fmta(" \\le ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = ">=", snippetType="autosnippet" },
        fmta(" \\ge ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "!=", snippetType="autosnippet" },
        fmta(" \\neq ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "oo", snippetType="autosnippet" },
        fmta("\\infty", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "tu", snippetType="autosnippet" },
        fmta("\\underline{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "tt", snippetType="autosnippet" },
        fmta("\\textit{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "tb", snippetType="autosnippet" },
        fmta("\\textbf{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "mc" },
        fmta("\\mathcal{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "mb" },
        fmta("\\mathbb{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "ss", snippetType="autosnippet" },
        fmta("\\SI{<>}{<>}", { d(1, helpers.get_visual), i(2) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "--", snippetType="autosnippet" },
        fmta("\\item{ <> }", { d(1, helpers.get_visual) }),
        { condition=helpers.in_itemize }
    ),
    s(
        { trig = "--", snippetType="autosnippet" },
        fmta("\\item [ <> ]", { d(1, helpers.get_visual) }),
        { condition=function() return helpers.in_env('multiproblem') end }
    ),
}

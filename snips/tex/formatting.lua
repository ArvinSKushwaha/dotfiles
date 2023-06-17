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
        { trig = "'e", snippetType="autosnippet" },
        fmta("\\epsilon", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = ";e", snippetType="autosnippet" },
        fmta("\\varepsilon", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'m", snippetType="autosnippet" },
        fmta("\\mu", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'f", snippetType="autosnippet" },
        fmta("\\phi", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'F", snippetType="autosnippet" },
        fmta("\\Phi", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'d", snippetType="autosnippet" },
        fmta("\\delta", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'D", snippetType="autosnippet" },
        fmta("\\Delta", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'p", snippetType="autosnippet" },
        fmta("\\psi", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'P", snippetType="autosnippet" },
        fmta("\\Psi", { }),
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
        { trig = "'G", snippetType="autosnippet" },
        fmta(" \\Gamma ", { }),
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
        { trig = "'O", snippetType="autosnippet" },
        fmta(" \\Omega ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'t", snippetType="autosnippet" },
        fmta(" \\theta ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'T", snippetType="autosnippet" },
        fmta(" \\Theta ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = ";t", snippetType="autosnippet" },
        fmta(" \\tau", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = ";T", snippetType="autosnippet" },
        fmta(" \\Tau", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'z", snippetType="autosnippet" },
        fmta(" \\zeta ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'l", snippetType="autosnippet" },
        fmta(" \\lambda ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'L", snippetType="autosnippet" },
        fmta(" \\Lambda ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'h", snippetType="autosnippet" },
        fmta(" \\hbar ", { }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "gn", snippetType="autosnippet" },
        fmta(" \\nabla ", { }),
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
        { trig = "=<", snippetType="autosnippet" },
        fmta(" \\impliedby ", { }),
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
        { trig = "td", snippetType="autosnippet" },
        fmta("\\underline{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "tt", snippetType="autosnippet" },
        fmta("\\textit{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "tt", snippetType="autosnippet" },
        fmta("\\text{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_mathzone}
    ),
    s(
        { trig = "tb", snippetType="autosnippet" },
        fmta("\\textbf{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "tb", snippetType="autosnippet" },
        fmta("\\mathbf{<>}", { d(1, helpers.get_visual) }),
        { condition=helpers.in_mathzone }
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
        { trig = "SS", snippetType="autosnippet" },
        fmta("\\SI{<>}{<>}", { d(1, helpers.get_visual), i(2) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "--", snippetType="autosnippet" },
        fmta("\\item <> ", { d(1, helpers.get_visual) }),
        { condition=function() return helpers.in_itemize() or helpers.in_env('enumerate') end }
    ),
    s(
        { trig = "--", snippetType="autosnippet" },
        fmta("\\item [ <> ]", { d(1, helpers.get_visual) }),
        { condition=function() return helpers.in_env('multiproblem') and not helpers.in_itemize end }
    ),
    s(
        { trig = "d'(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>", { d(1, function (args, parents, user_args)
            local idx = tonumber(parents.captures[1])
            local table = {
                "\\dot",
                "\\ddot",
                "\\dddot",
            }

            if (table[idx]) then
                return sn(
                    nil, fmta(table[idx] .. "{<>}", { i(1) })
                )
            else
                return sn(nil, { t("") })
            end
        end) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet", },
        fmta("<>_{<>}", { f(function(args, parents, user_args)
            return parents.captures[1]
        end, {}, {}), d(1, function(args, parents, user_args)
            return sn(nil, fmta(parents.captures[2] .. "<>", { i(1) }))
        end) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'u", snippetType = "autosnippet", wordTrig = false },
        fmta("_{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "'s", snippetType = "autosnippet", wordTrig = false },
        fmta("^{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "int" },
        fmta([[\int <> \odif{<>}]], { i(1), i(2, "x") }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "dsum" },
        fmta([[\sum^{<>}_{<>} <>]], { i(3), i(2), i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "df", snippetType = "autosnippet" },
        fmta("\\odv[ord=<>]{<>}{<>}", { i(3, "1"), i(1), i(2) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "pdf", snippetType = "autosnippet" },
        fmta("\\pdv[ord=<>]{<>}{<>}", { i(3, "1"), i(1), i(2) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "bb", snippetType = "autosnippet" },
        fmta("\\bra{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "kk", snippetType = "autosnippet" },
        fmta("\\ket{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "kb", snippetType = "autosnippet" },
        fmta("\\ket{<>}\\bra{<>}", { i(1), rep(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "bk", snippetType = "autosnippet" },
        fmta("\\braket{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "vv", snippetType = "autosnippet" },
        fmta("\\vec{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "hh", snippetType = "autosnippet" },
        fmta("\\hat{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "<s", snippetType = "autosnippet" },
        fmta("\\subseteq", {}),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "mt", snippetType = "autosnippet" },
        fmta("\\mappingto{<>}{<>}{<>}", { i(1), i(2), i(3) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "mp", snippetType = "autosnippet" },
        fmta("\\mapping{<>}{<>}{<>}", { i(1), i(2), i(3) }),
        { condition=helpers.in_mathzone }
    )
}

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
local p = extras.partial local m = extras.match
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
        { trig = "assignment", snippetType="autosnippet" },
        fmta([[
            \documentclass[14pt]{assignment}

            \usepackage{tikz}
            \usepackage{mathtools}
            \usepackage{setspace}

            \student{<>}
            \teacher{<>}
            \course{<>}
            \homeworktype{<>}
            \homeworkcount{<>}
            \duedate{<>}

            \begin{document}
                \maketitle

                <>
            \end{document}
        ]], { i(1, "Arvin Kushwaha"), i(2), i(3), i(4, "Homework"), i(5), i(6), i(7) })
    ),
}
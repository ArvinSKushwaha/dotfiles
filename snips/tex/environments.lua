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

function symbolify_cmd(expression)
    return string.format("from sympy import *;x, y, z, t = symbols('x y z t');k, m, n = symbols('k m n', integer=True);f, g, h = symbols('f g h', cls=Function);init_printing();print(eval('latex(' + %q.replace('\\\\', '').replace('^', '**').replace('{', '(').replace('}', ')') + ')'))", expression)
end

function texhandler(args, parent, user_args)
    local expression = symbolify_cmd(parent.captures[1])
    local result, code = helpers.execute({ "python",  "-c", expression })
    if code ~= 0 then
        return parent.captures[1]
    else
        return result
    end
end

function symbolify_do_cmd(expression)
    return string.format("from sympy import *;x, y, z, t = symbols('x y z t');k, m, n = symbols('k m n', integer=True);f, g, h = symbols('f g h', cls=Function);init_printing();strng=%q.replace('\\\\', '').replace('^', '**').replace('{', '(').replace('}', ')');print(eval(f'latex(Eq({strng}, {strng}.doit(), evaluate=False))'))", expression)
end

function latex2sympy_doit(expression)
    return string.format("from sympy import Eq;from latex2sympy2 import latex2latex, latex2sympy, latex;strng=%q;print(latex(Eq(latex2sympy(strng), latex2sympy(strng).doit(), evaluate=False)))", table.concat(expression, '\n'))
end

function texdohandler(args, parent, user_args)
    local expression = symbolify_do_cmd(parent.captures[1])
    return vim.fn.systemlist({ "python",  "-c", expression })
end

function doithandler(args, parent, user_args)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        local expression = latex2sympy_doit(parent.snippet.env.SELECT_RAW)
        return vim.fn.systemlist({ "python",  "-c", expression })
    else  
        return "Error..."
    end
end

function matrix_handler(args, parent, user_args)
    local start, finish = parent.captures[1], parent.captures[4]
    local rows, cols = tonumber(parent.captures[2]), tonumber(parent.captures[3])
    local matrix = {}
    local nodes = {}
    local tabstop = string.rep(' ', vim.opt.tabstop:get())

    for row=1,rows do
        table.insert(matrix, {})
        for col=1,cols do
            table.insert(matrix[row], '<>')

            local def = 0

            if row == col and rows == cols then
                def = 1 
            end

            table.insert(nodes, i((row - 1) * cols + col, tostring(def)))
        end
        matrix[row] = table.concat(matrix[row], ' & ') .. ' \\\\'
    end

    return sn(nil, fmta(
        string.format("\\begin{%s}\n<>\n\\end{%s}", start, finish),
        {
            d(1, function(args, parent, user_args)
                return isn(nil,
                    fmta(
                        tabstop .. table.concat(matrix, '\n'),
                        nodes
                    ),
                    "$PARENT_INDENT" .. tabstop
                )
            end, {}, {})
        }
    ))
end

return {
    s(
        { trig = "ff", snippetType="autosnippet" },
        fmta("\\frac{<>}{<>}", { i(1), i(2) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "pp", snippetType="autosnippet" },
        fmta("\\p{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "dbr", snippetType="autosnippet" },
        fmta("\\br{<>}", { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "cbr", snippetType="autosnippet" },
        fmta("\\cbr{<>}", { i(1) })
    ),
    s(
        { trig = "qq", snippetType="autosnippet" },
        fmta([[
            \begin{equation*}
                <>
            \end{equation*}
        ]], { i(1) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "bm", snippetType="autosnippet" },
        fmta([[
            \begin{bmatrix}
                <>
            \end{bmatrix}
        ]], { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "vm", snippetType="autosnippet" },
        fmta([[
            \begin{vmatrix}
                <>
            \end{vmatrix}
        ]], { i(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "mm", snippetType="autosnippet" },
        fmta("\\( <> \\)", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "MM", snippetType="autosnippet" },
        fmta("\\[ <> \\]", { d(1, helpers.get_visual) }),
        { condition=helpers.in_text }
    ),
    s(
        { trig = "dnv", snippetType="autosnippet" },
        fmta([[
            \begin{<>}
               <>
            \end{<>}
        ]], { i(1), i(0), rep(1) })
    ),
    s(
        { trig = "dkz", snippetType="autosnippet" },
        fmta([[
            \begin{figure}
               \centering
               \begin{tikzpicture}
                  <>
               \end{tikzpicture}
            \end{figure}
        ]], { i(1) })
    ),
    s(
        { trig = "sb", snippetType="autosnippet" },
        fmta("[expr] <> [expr]", { i(1) })
    ),
    s(
        { trig = "sd", snippetType="autosnippet" },
        fmta("[exprdo] <> [exprdo]", { i(1) })
    ),
    s(
        { trig = "%[expr%] (.*) %[expr%]", regTrig = true, wordTrig = false },
        fmta("<>", { f(texhandler, {}, {}) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "%[exprdo%] (.*) %[exprdo%]", regTrig = true, wordTrig = false },
        fmta("<>", { f(texdohandler, {}, {}) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "doit" },
        fmta("<>", { f(doithandler, {}, {}) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "mat", snippetType="autosnippet" },
        fmta([[
            \begin{<>matrix} {<>,<>} \end{<>matrix}
        ]], { i(1, "b"), i(2), i(3), rep(1) }),
        { condition=helpers.in_mathzone }
    ),
    s(
        { trig = "\\begin{(%amatrix)}.*{(%d+),(%d+)}.*\\end{(%amatrix)}", regTrig = true, wordTrig = false },
        fmta("<>", { d(1, matrix_handler) }),
        { condition=helpers.in_mathzone }
    )
}

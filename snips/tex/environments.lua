local helpers = require("luasnip-helpers")
local Job = require("plenary.job")
local Path = require("plenary.path")

local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

function symbolify_cmd(expression)
	return string.format(
		"from sympy import * \n"
			.. "x, y, z, t = symbols('x y z t') \n"
			.. "k, m, n = symbols('k m n', integer=True) \n"
			.. "f, g, h = symbols('f g h', cls=Function) \n"
			.. "init_printing() \n"
			.. "strng = %q.replace(r'\\', '').replace('^', '**').replace('{', '(').replace('}', ')') \n"
			.. "print(eval(f'latex({strng}, evaluate=false)'))",
		expression
	)
end

function texhandler(args, parent, user_args)
	local expression = symbolify_cmd(parent.captures[1])
	local result, code = helpers.execute({ "python", "-c", expression })
	if code ~= 0 then
		return parent.captures[1]
	else
		return result
	end
end

function symbolify_do_cmd(expression)
	return string.format(
		"from sympy import * \n"
			.. "x, y, z, t = symbols('x y z t') \n"
			.. "k, m, n = symbols('k m n', integer=True) \n"
			.. "f, g, h = symbols('f g h', cls=Function) \n"
			.. "init_printing() \n"
			.. "strng = %q.replace(r'\\', '').replace('^', '**').replace('{', '(').replace('}', ')') \n"
			.. "print(eval(f'latex(Eq({strng}, {strng}.doit(), evaluate=False))'))",
		expression
	)
end

function latex2sympy_doit(expression)
	return string.format(
		"from sympy import Eq \n"
			.. "from latex2sympy2 import latex2latex, latex2sympy, latex \n"
			.. "strng = %q \n"
			.. "strng = string.replace('\\t', '').replace('\\n', '').strip() \n"
			.. "expr = latex2sympy(strng) \n"
			.. "print(latex(Eq(expr, expr.doit(), evaluate=False)))",
		table.concat(expression, "\\n")
	)
end

function texdohandler(args, parent, user_args)
	local expression = symbolify_do_cmd(parent.captures[1])
	return vim.fn.systemlist({ "python", "-c", expression })
end

function doithandler(args, parent, user_args)
	if #parent.snippet.env.SELECT_RAW == 0 then
		return "Error..."
	end

	local expression = latex2sympy_doit(parent.snippet.env.SELECT_RAW)
	local job = Job:new({
		command = "python",
		args = { "-" },
		enable_handlers = true,
		enable_recording = true,
		interactive = true,
	})
	job:start()
	job:send(expression)
	job:wait(10000, nil, true)

	if job.code ~= 0 then
		local log_file = Path:new("/tmp/doit_err.log")
		vim.print(expression)
		vim.print(job:stderr_result())
		log_file:write(expression .. "\n" .. job:stderr_result(), "a")

		return parent.snippet.env.SELECT_RAW
	else
		local log_file = Path:new("/tmp/doit_err.log")
		vim.print(expression)
		vim.print(job:stderr_result())
		log_file:write(expression .. "\n" .. job:stderr_result(), "a")
		return job:result()
	end
end

function matrix_handler(args, parent, user_args)
	local start = parent.captures[1] .. "matrix"
	local rows, cols = tonumber(parent.captures[2]), tonumber(parent.captures[3])
	local matrix = {}
	local nodes = {}
	local tabstop = string.rep(" ", vim.opt.tabstop:get())

	for row = 1, rows do
		table.insert(matrix, {})
		for col = 1, cols do
			table.insert(matrix[row], "<>")

			local def = 0

			if row == col and rows == cols then
				def = 1
			end

			table.insert(nodes, i((row - 1) * cols + col, tostring(def)))
		end
		matrix[row] = table.concat(matrix[row], " & ") .. [[ \\ ]]
	end

	return sn(
		nil,
		fmta(string.format("\\begin{%s}\n<>\n\\end{%s}", start, start), {
			d(1, function(args, parent, user_args)
				return isn(nil, fmta(tabstop .. table.concat(matrix, "\n"), nodes), "$PARENT_INDENT" .. tabstop)
			end, {}, {}),
		})
	)
end

return {
	s(
		{ trig = "tq", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{equation}
                <>
            \end{equation}
            ]],
			{ i(1) }
		),
		{ condition = helpers.in_text * conds_expand.line_begin }
	),
	s(
		{ trig = "tn", snippetType = "autosnippet" },
		fmta("\\( <> \\)", { d(1, helpers.get_visual) }),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "tm", snippetType = "autosnippet" },
		fmta(
			[[
            \[
                <>
            .\]
        ]],
			{ d(1, helpers.get_visual) }
		),
		{ condition = helpers.in_text * conds_expand.line_begin }
	),
	s(
		{ trig = "dnv", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{<>}
                <>
            \end{<>}
        ]],
			{ i(1), i(0), rep(1) }
		)
	),
	s(
		{ trig = "dtm", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{itemize}
                <>
            \end{itemize}
        ]],
			{ i(1) }
		),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "dnm", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{enumerate}
                <>
            \end{enumerate}
        ]],
			{ i(1) }
		),
		{ condition = helpers.in_text }
	),
	s(
		{ trig = "dkz", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{figure}
                \centering
                \begin{tikzpicture}
                    <>
                \end{tikzpicture}
            \end{figure}
        ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "dimg", snippetType = "autosnippet" },
		fmta(
			[[
            \begin{figure}
                \centering
                \includegraphics[<>]{<>}
                \caption{<>}
                \label{<>}
            \end{figure}
        ]],
			{ i(2), i(1), i(3), i(4) }
		)
	),
	s(
		{ trig = "!xp", snippetType = "autosnippet" },
		fmta("%expr <> %expr", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "!xdo", snippetType = "autosnippet" },
		fmta("%exprdo <> %exprdo", { i(1) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "%%expr%% (.*) %%expr%%", regTrig = true, wordTrig = false },
		fmta("<>", { f(texhandler, {}, {}) }),
		{ condition = helpers.in_mathzone }
	),
	s(
		{ trig = "%%exprdo%% (.*) %%exprdo%%", regTrig = true, wordTrig = false },
		fmta("<>", { f(texdohandler, {}, {}) }),
		{ condition = helpers.in_mathzone }
	),
	-- s({ trig = "doit" }, fmta("<>", { f(doithandler, {}, {}) }), { condition = helpers.in_mathzone }),
	s(
		{ trig = "mx([bBvVpn])", snippetType = "autosnippet", regTrig = true },
		fmta(
			[[
                %<>matrix(<>,<>)
            ]],
			{
				f(function(args, parents, user_args)
					if parents.captures[1] == "n" then
						return ""
					else
						return parents.captures[1]
					end
				end),
				i(1),
				i(2),
			}
		),
		{ condition = helpers.in_mathzone }
	),
	s({
		trig = "%%([%a]?)matrix%((%d+),(%d+)%)",
		regTrig = true,
		wordTrig = false,
	}, fmta("<>", { d(1, matrix_handler) }), { condition = helpers.in_mathzone }),
	s(
		{ trig = "pkg" },
		fmta(
			[[
            \usepackage[<>]{<>}
            ]],
			{ i(2), i(1) }
		)
	),
}

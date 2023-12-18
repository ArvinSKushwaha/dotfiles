ls = require("luasnip")
s = ls.snippet
sn = ls.snippet_node
isn = ls.indent_snippet_node
t = ls.text_node
i = ls.insert_node
f = ls.function_node
c = ls.choice_node
d = ls.dynamic_node
r = ls.restore_node
events = require("luasnip.util.events")
ai = require("luasnip.nodes.absolute_indexer")
extras = require("luasnip.extras")
l = extras.lambda
rep = extras.rep
p = extras.partial
m = extras.match
n = extras.nonempty
dl = extras.dynamic_lambda
fmt = require("luasnip.extras.fmt").fmt
fmta = require("luasnip.extras.fmt").fmta
conds = require("luasnip.extras.expand_conditions")
postfix = require("luasnip.extras.postfix").postfix
types = require("luasnip.util.types")
parse = require("luasnip.util.parser").parse_snippet
ms = ls.multi_snippet

conds = require("luasnip.extras.conditions")
conds_expand = require("luasnip.extras.conditions.expand")

conds.btrue = conds.make_condition(function()
	return true
end)
conds.bfalse = conds.make_condition(function()
	return false
end)

-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local helpers = {}

helpers.in_mathzone = conds.make_condition(function() -- math context detection
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end)

helpers.in_text = conds.make_condition(function()
	return not helpers.in_mathzone()
end)

helpers.in_comment = conds.make_condition(function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end)

helpers.in_env = function(name)
	return conds.make_condition(function() -- generic environment detection
		local is_inside = vim.fn["vimtex#env#is_inside"](name)
		return (is_inside[1] > 0 and is_inside[2] > 0)
	end)
end

-- A few concrete environments---adapt as needed
helpers.in_equation = helpers.in_env("equation")
helpers.in_itemize = helpers.in_env("itemize")
helpers.in_tikz = helpers.in_env("tikzpicture")

helpers.get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

helpers.execute = function(cmd)
	local ret = vim.fn.systemlist(cmd)
	local code = vim.api.nvim_get_vvar("shell_error")
	return ret, code
end

return helpers

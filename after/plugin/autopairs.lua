local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local npairs = require('nvim-autopairs')

npairs.get_rules("'")[1]:with_pair(cond.not_after_text("#"))


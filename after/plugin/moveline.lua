local map = vim.keymap.set

local moveline = require("moveline")
map("n", "<S-Up>", moveline.up, {})
map("n", "<S-Down>", moveline.down, {})

map("v", "<S-Up>", moveline.block_up, {})
map("v", "<S-Down>", moveline.block_down, {})

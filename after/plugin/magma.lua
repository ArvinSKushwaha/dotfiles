local magma_options = {
	magma_automatically_open_output = 0,
	magma_image_provider = "kitty",
}

for op, val in pairs(magma_options) do
	vim.g[op] = val
end

local map = vim.keymap.set

vim.g.maplocalleader = ","

map("n", "<LocalLeader>r", ":MagmaEvaluateOperator<CR>", { silent = true, expr = true })
map("n", "<LocalLeader>rr", ":MagmaEvaluateLine<CR>", { silent = true })
map("x", "<LocalLeader>r", ":<C-u>MagmaEvaluateVisual<CR>", { silent = true })
map("n", "<LocalLeader>rc", ":MagmaReevaluateCell<CR>", { silent = true })
map("n", "<LocalLeader>rd", ":MagmaDelete<CR>", { silent = true })
map("n", "<LocalLeader>ro", ":MagmaShowOutput<CR>", { silent = true })

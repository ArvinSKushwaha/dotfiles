local map = vim.keymap.set

map("n", "<F5>", vim.cmd.UndotreeToggle, { noremap = true })
vim.o.undofile = true

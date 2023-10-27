vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.pym" }, command = "set filetype=python" })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.jlm" }, command = "set filetype=julia" })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.wgsl" }, command = "set filetype=wgsl" })

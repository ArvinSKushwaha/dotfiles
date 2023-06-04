vim.api.nvim_create_autocmd(
    { "BufRead" },
    { pattern = { "*.tex" }, command = "setlocal conceallevel=1" }
)

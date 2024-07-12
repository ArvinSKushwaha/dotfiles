local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>T", function()
    vim.cmd("ClangdSwitchSourceHeader")
end, { silent = true, buffer = bufnr, noremap = false })


local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>N", function()
    vim.cmd.RustLsp({ "ssr" })
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>T", function()
    vim.cmd.RustLsp('testables')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>R", function()
    vim.cmd.RustLsp('runnables')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>D", function()
    vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>d", function()
    vim.cmd.RustLsp('openDocs')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>P", function()
    vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>S", function()
    vim.cmd.RustLsp('workspaceSymbol')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>E", function()
    vim.cmd.RustLsp('expandMacro')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>o", function()
    vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr, noremap = false })

vim.keymap.set("n", "<leader>c", function()
    vim.cmd.RustLsp('flyCheck')
end, { silent = true, buffer = bufnr, noremap = false })

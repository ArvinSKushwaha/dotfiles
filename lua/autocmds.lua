vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.tex" }, command = "set conceallevel=0" })

local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = lsp_fmt_group,
  callback = function(ev)
    local efm = vim.lsp.get_active_clients({ name = 'efm', bufnr = ev.buf })

    if vim.tbl_isempty(efm) then
      return
    end

    vim.lsp.buf.format({ name = 'efm' })
  end,
})

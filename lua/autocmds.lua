vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.tex" }, command = "set conceallevel=0" })
-- vim.api.nvim_create_autocmd(
-- 	{ "VimtexEventCompileStopped", "VimtexEventQuit" },
-- 	{ pattern = { "*.tex" }, command = "VimtexStop;VimtexClean" }
-- )

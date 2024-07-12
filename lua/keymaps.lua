local map = vim.keymap.set
local telescope_builtin = require("telescope.builtin")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("n", "<leader>q", ":bd<CR>", {})
map("n", "<leader>Q", ":bd!<CR>", {})
map("n", "<leader>wf", ":q<CR>", {})
map("n", "<leader>wq", ":qa<CR>", {})
map("n", "<leader>wQ", ":qa!<CR>", {})
map("n", "<leader>p", '"0p', {})
map("n", "<leader>y", '"0y', {})
map("n", "<C-s>", ":w<CR>", {})
map("n", "<C-S>", ":w!<CR>", {})

----------------
--[[ Motion ]]
----------------

map("n", "Up", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
map("v", "Up", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })

map("n", "Down", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })
map("v", "Down", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })

map("n", "<C-a>", "ggVG", { noremap = true })
map("n", "<C-c>", ":%y<CR>", { noremap = true })

map("i", "<C-.>", "<C-t>", { noremap = true })
map("i", "<C-,>", "<C-d>", { noremap = true })

map("n", "<C-.>", ">>", { noremap = true })
map("n", "<C-,>", "<<", { noremap = true })

map("v", "<C-.>", ">gv", { noremap = true })
map("v", "<C-,>", "<gv", { noremap = true })

map("n", "<A-f>", ":tabnext<CR>", { noremap = true })
map("n", "<A-w>", ":tabprevious<CR>", { noremap = true })

map("n", "<A-Left>", "<C-w><Left>", { noremap = true })
map("n", "<A-Down>", "<C-w><Down>", { noremap = true })
map("n", "<A-Up>", "<C-w><Up>", { noremap = true })
map("n", "<A-Right>", "<C-w><Right>", { noremap = true })

map("n", "<A-S-Left>", "<C-w>H", { noremap = true })
map("n", "<A-S-Down>", "<C-w>J", { noremap = true })
map("n", "<A-S-Up>", "<C-w>K", { noremap = true })
map("n", "<A-S-Right>", "<C-w>L", { noremap = true })

-- map("n", "<C-Left>", "<C-W><<CR>", { noremap = true })
-- map("n", "<C-Down>", "<C-W>-<CR>", { noremap = true })
-- map("n", "<C-Up>", "<C-W>+<CR>", { noremap = true })
-- map("n", "<C-Right>", "<C-W>><CR>", { noremap = true })

-- map("n", "<leader><Home>", "^", { noremap = true })
-- map("n", "<leader><End>", "$", { noremap = true })

map("i", "<Home>", "<C-o>^", { noremap = true })
map("i", "<End>", "<C-o>$", { noremap = true })

--------------
--[[ Lazy ]]
--------------

map("n", "<leader>u", ":Lazy<CR>", { noremap = true })

-------------------
--[[ Telescope ]]
-------------------

map("n", "<leader>r", telescope_builtin.find_files, { noremap = true })
map("n", "<leader>f", function()
	local opts = {} -- define here if you want to define something

	vim.fn.system("git rev-parse --is-inside-work-tree")
	local is_inside_work_tree = vim.v.shell_error == 0

	if is_inside_work_tree then
		telescope_builtin.git_files(opts)
	else
		telescope_builtin.find_files(opts)
	end
end, { noremap = true })
map("n", "<leader>s", telescope_builtin.live_grep, { noremap = true })
map("n", "<leader>t", telescope_builtin.builtin, { noremap = true })

--------------
--[[ LSP ]]
--------------

map("n", ";l", function()
	if vim.bo.filetype == "rust" then
        local bufnr = vim.api.nvim_get_current_buf()
        vim.print(bufnr)
        require("rustaceanvim.lsp").start(bufnr)
	else
		vim.cmd("LspStart")
	end
end, { noremap = true })
map("n", ";s", function()
	if vim.bo.filetype == "rust" then
        local bufnr = vim.api.nvim_get_current_buf()
        require("rustaceanvim.lsp").stop(bufnr)
	else
		vim.cmd("LspStop")
	end
end, { noremap = true })
map("n", ";r", function()
	if vim.bo.filetype == "rust" then
        local bufnr = vim.api.nvim_get_current_buf()
        require("rustaceanvim.lsp").restart(bufnr)
	else
		vim.cmd("LspRestart")
	end
end, { noremap = true })
map("n", ";i", function()
	if vim.bo.filetype == "rust" then
		vim.cmd("RustInfo")
	else
		vim.cmd("LspInfo")
	end
end, { noremap = true })
map("n", ";u", ":Mason<CR>", { noremap = true })

--------------------
--[[ Formatting ]]
--------------------

map("n", ",f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true })
map("v", ",f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true })

-------------
--[[ Hop ]]
-------------

map("n", "<leader>h", ":HopWord<CR>", { noremap = true })
map("n", "<leader>k", ":HopPattern<CR>", { noremap = true })

------------------
--[[ LuaSnips ]]
------------------

map("n", "<leader>L", function()
	require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snips" })
end)
map("i", "<C-c>", "<Plug>luasnip-next-choice", { noremap = true })
map("s", "<C-c>", "<Plug>luasnip-next-choice", { noremap = true })
map("i", "<C-x>", "<Plug>luasnip-prev-choice", { noremap = true })
map("s", "<C-x>", "<Plug>luasnip-prev-choice", { noremap = true })

-------------------------
--[[ MarkdownPreview ]]
--[[      Vimtex     ]]
-------------------------

map("n", "<leader>v", function()
	if vim.bo.filetype == "tex" or vim.bo.filetype == "latex" then
		vim.cmd("VimtexCompile")
	elseif vim.bo.filetype == "markdown" then
		vim.cmd("MarkdownPreviewToggle")
	end
end, { noremap = true })

map("n", "<tab>", function()
	if vim.bo.filetype == "tex" or vim.bo.filetype == "latex" then
		vim.cmd("VimtexTocToggle")
	end
end, { noremap = true })

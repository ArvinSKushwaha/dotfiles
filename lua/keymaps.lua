local map = vim.keymap.set
local telescope_builtin = require("telescope.builtin")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("n", "<leader>d", ":bd<CR>", {})
map("n", "<leader>D", ":bd!<CR>", {})
map("n", "<leader>wf", ":q<CR>", {})
map("n", "<leader>wq", ":qa<CR>", {})
map("n", "<leader>wQ", ":qa!<CR>", {})
map("n", "<leader>p", '"0p', {})
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

map("n", "<C-Left>", "<C-W><<CR>", { noremap = true })
map("n", "<C-Down>", "<C-W>-<CR>", { noremap = true })
map("n", "<C-Up>", "<C-W>+<CR>", { noremap = true })
map("n", "<C-Right>", "<C-W>><CR>", { noremap = true })

map("n", "<leader><Home>", "^", { noremap = true })
map("n", "<leader><End>", "$", { noremap = true })

map("i", "<Home>", "<C-o>^", { noremap = true })
map("i", "<End>", "<C-o>$", { noremap = true })

map("n", "<leader>yy", "gww", { noremap = true })
map("n", "<leader>y", "gw", { noremap = true })
map("v", "<leader>y", "gw", { noremap = true })

--------------
--[[ Lazy ]]
--------------

map("n", "<leader>u", ":Lazy<CR>", { noremap = true })

-- -------------------
-- --[[ Nvim Tree ]]
-- -------------------
--
-- map("n", "<leader>o", require("nvim-tree.api").tree.toggle, { noremap = true })

-------------------
--[[ Telescope ]]
-------------------

map("n", "<leader>r", telescope_builtin.find_files, { noremap = true })
map("n", "<leader>f", function()
	local opts = {} -- define here if you want to define something

	local cwd = vim.fn.getcwd()
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

map("n", ";l", ":LspStart<CR>", { noremap = true })
map("n", ";s", ":LspStop<CR>", { noremap = true })
map("n", ";r", ":LspRestart<CR>", { noremap = true })
map("n", ";i", ":LspInfo<CR>", { noremap = true })
map("n", ";u", ":Mason<CR>", { noremap = true })

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

----------------------
--[[ MultiCursor ]]
--
----------------------

map("n", "<C-A-i>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>", { noremap = true, silent = true })

map("n", "<C-A-e>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>", { noremap = true, silent = true })

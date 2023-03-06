vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.python3_host_prog = '/usr/bin/python3'

local options = {
	autochdir = false,
	autoindent = true,
	background = "dark",
	clipboard = "unnamed,unnamedplus",
	cmdheight = 1,
	compatible = false,
    conceallevel = 0,
	cursorline = true,
    encoding = "utf-8",
	expandtab = true,
	fileencoding="utf-8",
	foldenable = false,
	foldexpr = 'nvim_treesitter#foldexpr()',
	foldmethod = 'expr',
    hidden = true,
	ignorecase = true,
	incsearch = true,
	laststatus = 3,
	linebreak = true,
	mouse = 'a',
    number = true,
	numberwidth = 5,
	pumheight = 15,
	relativenumber = false,
	ruler = true,
	shell = '/bin/fish',
    shiftwidth = 4,
	showmode = false,
	smartcase = true,
    smarttab = true,
	splitbelow = true,
	splitright = true,
    tabstop = 4,
	termguicolors = true,
	title = true,
	updatetime = 0,
	virtualedit = "onemore",
}

-- Set options
for op, val in pairs(options) do
    vim.opt[op] = val
end

vim.opt.shortmess:append("sI")
vim.opt.complete:append("kspell")

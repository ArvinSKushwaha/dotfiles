local custom_options = {
    instant_username = "Arvin Kushwaha",
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    neovide_cursor_animate_command_line = false,
    neovide_cursor_animate_in_insert_mode = false,
    neovide_cursor_animation_length = 0.07,
    neovide_hide_mouse_when_typing = true,
    neovide_scale_factor = 0.6,
    python3_host_prog = "/usr/bin/python3",
    tex_conceal='abdmg',
    tex_flavor = 'latex',
    vimspector_bottombar_height = 15,
    vimspector_sidebar_width = 85,
    vimspector_terminal_maxwidth = 70,
    vimtex_view_general_viewer = 'zathura',
    vimtex_quickfix_mode = 0,
}

for op, val in pairs(custom_options) do
    vim.g[op] = val
end

local options = {
	autochdir = false,
	autoindent = true,
	background = "dark",
	clipboard = "unnamed,unnamedplus",
	cmdheight = 1,
	compatible = false,
    completeopt = { 'menuone', 'noselect', 'noinsert' },
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
	relativenumber = true,
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
    scrolloff = 8,
    guifont = "JetBrains Mono Nerd Font:h9",
}

-- Set options
for op, val in pairs(options) do
    vim.opt[op] = val
end

vim.opt.shortmess:append("scI")
vim.opt.complete:append("kspell")

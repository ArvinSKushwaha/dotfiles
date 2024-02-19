local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	"andymass/vim-matchup",
	"axvr/zepl.vim",
	"feline-nvim/feline.nvim",
	"FelipeLema/cmp-async-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-omni",
	"hrsh7th/nvim-cmp",
	"iago-lito/vim-visualMarks",
	"jay-babu/mason-nvim-dap.nvim",
	"lervag/vimtex",
	"mbbill/undotree",
	"mfussenegger/nvim-dap",
	"mg979/vim-visual-multi",
	"nanotee/zoxide.vim",
	"neovim/nvim-lspconfig",
	"nvim-tree/nvim-web-devicons",
	"saadparwaiz1/cmp_luasnip",
	"stevearc/oil.nvim",
	"tpope/vim-fugitive",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"wsdjeg/vim-fetch",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"creativenull/efmls-configs-nvim",
		version = "v1.x.x", -- version is optional, but recommended
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
		config = function()
            require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "tex" } })
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		build = [[make install_jsregexp]],
	},
	{
		"willothy/moveline.nvim",
		build = [[rustup default stable; make]],
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		lazy = true,
		cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
		build = [[cd app && npm install && git reset --hard]],
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{
		"saecki/crates.nvim",
		version = "v0.4.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		config = function()
			require("hop").setup({ keys = "arseioqwfpbjluyxcdvzkh" })
		end,
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.4",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	version = "nightly", -- optional, updated every week. (see issue #1193)
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	{ "dccsillag/magma-nvim", build = ":UpdateRemotePlugins" },
})

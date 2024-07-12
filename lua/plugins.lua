local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
	"freddiehaddad/feline.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-omni",
	"hrsh7th/cmp-path",
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
	"p00f/clangd_extensions.nvim",
	"saadparwaiz1/cmp_luasnip",
	"stevearc/oil.nvim",
	"stevearc/conform.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-abolish",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"wsdjeg/vim-fetch",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"Bilal2453/luvit-meta",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { disable_filetype = { "TelescopePrompt", "tex" } },
		-- config = function()
		-- 	require("nvim-autopairs").setup()
		-- end,
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
		"ArvinSKushwaha/markdown-preview.nvim",
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
		opts = {},
		-- config = function()
		-- 	require("Comment").setup()
		-- end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
		-- config = function()
		-- 	require("nvim-surround").setup({})
		-- end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = { keys = "arseioqwfpbjluyxcdvzkh", multi_windows = true, uppercase_labels = true },
		-- config = function()
		-- 	require("hop").setup({ keys = "arseioqwfpbjluyxcdvzkh" })
		-- end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "v1.4.5",
		opts = { notification = { window = { winblend = 0 } } },
		-- config = function()
		-- 	require("fidget").setup({
		-- 		notification = {
		-- 			window = {
		-- 				winblend = 0,
		-- 			},
		-- 		},
		-- 	})
		-- end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
		-- config = function()
		-- 	require("todo-comments").setup({})
		-- end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.7",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	{ "dccsillag/magma-nvim", build = ":UpdateRemotePlugins" },
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		opts = {
			mappings = true,
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "arvim",
					path = "~/Nextcloud/arvim/",
				},
			},
            log_level = vim.log.levels.WARN,
		},
	},
})

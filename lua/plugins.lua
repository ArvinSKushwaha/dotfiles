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
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "elkowar/yuck.vim",
    "saadparwaiz1/cmp_luasnip",
    "feline-nvim/feline.nvim",
    "jbyuki/instant.nvim",
    "kdheepak/lazygit.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "hrsh7th/nvim-cmp",
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter-context",
    "simrat39/rust-tools.nvim",
    "preservim/tagbar",
    "akinsho/toggleterm.nvim",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "lervag/vimtex",
    "axvr/zepl.vim",
    "nanotee/zoxide.vim",
    "wsdjeg/vim-fetch",
    "fladson/vim-kitty",
    "ixru/nvim-markdown",
    "mg979/vim-visual-multi",
    "elihunter173/dirbuf.nvim",
    {
        "LhKipp/nvim-nu",
        config = function() require("nu").setup{} end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        lazy = true,
        cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install && git reset --hard",
    },
    { "catppuccin/nvim", name = "catppuccin" },
    -- "luk400/vim-jukit",
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup({ }) end
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function() require("hop").setup {} end
    },
    {
        "j-hui/fidget.nvim", 
        branch = "legacy",
        config = function() require("fidget").setup {} end
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup { mode = "workspace_diagnostics" }
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup {} end
    },
    {
        "nvim-telescope/telescope.nvim", version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        version = "nightly",                   -- optional, updated every week. (see issue #1193)

    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },
    -- {
    --     "folke/noice.nvim",
    --     config = function()
    --         require("noice").setup({
    --             lsp = {
    --                 -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true,
    --                 },
    --             },
    --             popupmenu = {
    --                 enabled = true, -- enables the Noice popupmenu UI
    --                 ---@type 'nui'|'cmp'
    --                 backend = "nui", -- backend to use to show regular cmdline completions
    --                 ---@type NoicePopupmenuItemKind|false
    --                 -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
    --                 kind_icons = {}, -- set to `false` to disable icons
    --             },
    --             -- you can enable a preset for easier configuration
    --             presets = {
    --                 bottom_search = false, -- use a classic bottom cmdline for search
    --                 command_palette = true, -- position the cmdline and popupmenu together
    --                 long_message_to_split = true, -- long messages will be sent to a split
    --                 inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --                 lsp_doc_border = true, -- add a border to hover docs and signature help
    --             },
    --             views = {
    --                 split = {
    --                     enter = true
    --                 }
    --             },
    --             routes = {
    --                 {
    --                     filter = {
    --                         event = "msg_show",
    --                         kind = "",
    --                     },
    --                     opts = { skip = true },
    --                 },
    --                 {
    --                     filter = {
    --                         event = "msg_show",
    --                         kind = "search_count",
    --                     },
    --                     opts = { skip = true },
    --                 },
    --                 {
    --                     filter = {
    --                         event = "msg_show",
    --                         kind = "",
    --                         find = "written",
    --                     },
    --                     opts = { skip = true },
    --                 },
    --             },
    --         })
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    -- }
    -- { "andweeb/presence.nvim", config = function() require("lazy_settings.presence") end }

})

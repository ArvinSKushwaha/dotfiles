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
    "saadparwaiz1/cmp_luasnip",
    "feline-nvim/feline.nvim",
    "jbyuki/instant.nvim",
    "kdheepak/lazygit.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "hrsh7th/nvim-cmp",
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
    "simrat39/rust-tools.nvim",
    "preservim/tagbar",
    "akinsho/toggleterm.nvim",
    "folke/tokyonight.nvim",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "puremourning/vimspector",
    "lervag/vimtex",
    "axvr/zepl.vim",
    "nanotee/zoxide.vim",
    { "catppuccin/nvim", name = "catppuccin" },
    -- "luk400/vim-jukit",
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup({ })
        end
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function() require "hop".setup {} end
    },
    {
        "j-hui/fidget.nvim", 
        config = function() require('fidget').setup {} end
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
    {
        'glacambre/firenvim',

        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        cond = not not vim.g.started_by_firenvim,
        build = function()
            require("lazy").load({ plugins = "firenvim", wait = true })
            vim.fn["firenvim#install"](0)
        end
    }
    -- { "andweeb/presence.nvim", config = function() require("lazy_settings.presence") end }

})

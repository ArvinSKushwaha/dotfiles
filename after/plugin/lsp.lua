require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local map_opts = { noremap = false, silent = true }
local map = vim.keymap.set

-- https://gist.github.com/tylerneylon/81333721109155b2d244
local function copy1(obj)
	if type(obj) ~= "table" then
		return obj
	end
	local res = {}
	for k, v in pairs(obj) do
		res[copy1(k)] = copy1(v)
	end
	return res
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = copy1(map_opts)
		opts.buffer = ev.bufnr

		map("n", "<leader>e", vim.diagnostic.open_float, opts)
		map("n", ")(", vim.diagnostic.goto_prev, opts)
		map("n", "()", vim.diagnostic.goto_next, opts)
		map("n", "<leader>l", vim.diagnostic.setloclist, opts)

		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		map("n", "<leader>gT", vim.lsp.buf.type_definition, opts)
		map("n", "<leader>n", vim.lsp.buf.rename, opts)
		map("n", "<leader>C", function()
			if vim.bo[ev.buf].filetype == "rust" then
				vim.cmd.RustLsp("codeAction")
			else
				vim.lsp.buf.code_action()
			end
		end, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<leader>et", function()
			vim.lsp.buf.typehierarchy("subtypes")
		end, opts)
		map("n", "<leader>eT", function()
			vim.lsp.buf.typehierarchy("supertypes")
		end, opts)
		map("n", "<leader>gi", vim.lsp.buf.incoming_calls, opts)
		map("n", "<leader>go", vim.lsp.buf.outgoing_calls, opts)
		map("n", "<leader>,", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.bufnr })
		end, opts)
	end,
})

local default_settings = {
	autostart = false,
	capabilities = capabilities,
	settings = {},
}

require("conform").setup({
	formatters_by_ft = {
		bib = { "bibtex-tidy" },
		c = { "clang-format" },
		c_sharp = { "astyle" },
		cmake = { "cmake_format" },
		cpp = { "clang-format" },
		cuda = { "clang-format" },
		hjson = { "fixjson" },
		java = { "astyle" },
		json = { "jq" },
		latex = { "latexindent" },
		lua = { "stylua" },
		markdown = { "injected" },
		python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
		rust = { "rustfmt" },
		sh = { "beautysh" },
		tex = { "latexindent" },
		toml = { "taplo" },
	},
})

require("conform").formatters.injected = {
	options = {
		ignore_errors = false,
		lang_to_ext = {
			bash = "sh",
			python = "py",
			latex = "tex",
			javascript = "js",
		},
	},
}

vim.g.rustaceanvim = {
	tools = {
		reload_workspace_from_cargo_toml = true,
		float_win_config = {
			style = "minimal",
			border = "rounded",
		},
	},
	server = {
		auto_attach = true,
		standalone = true,
		settings = function(project_root)
			local ra = require("rustaceanvim.config.server")
			return ra.load_rust_analyzer_settings(project_root, {
				settings_file_pattern = "rust-analyzer.json",
			})
		end,
	},
	dap = {},
}

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup(copy1(default_settings))
	end,

	["rust_analyzer"] = function() end,

	["julials"] = function()
		local settings = copy1(default_settings)
		settings.filetypes = { "julia", "jl" }
		require("lspconfig")["julials"].setup(settings)
	end,

	["lua_ls"] = function()
		local settings = copy1(default_settings)
		settings.settings["Lua"] = {
			runtime = {
				version = "LuaJIT",
			},
			telemetry = {
				enable = false,
			},
		}
		require("lspconfig")["lua_ls"].setup(settings)
	end,
})

require("mason-nvim-dap").setup({
	automatic_setup = true,
})

require("clangd_extensions").setup({
	ast = {
		role_icons = {
			type = "",
			declaration = "",
			expression = "",
			specifier = "",
			statement = "",
			["template argument"] = "",
		},

		kind_icons = {
			Compound = "",
			Recovery = "",
			TranslationUnit = "",
			PackExpansion = "",
			TemplateTypeParm = "",
			TemplateTemplateParm = "",
			TemplateParamObject = "",
		},
	},
	memory_usage = {
		border = "rounded",
	},
	symbol_info = {
		border = "rounded",
	},
})
require("crates").setup()

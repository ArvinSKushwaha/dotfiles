require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local opts = { noremap = false, silent = true }
local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		map("n", "<space>e", vim.diagnostic.open_float, opts)
		map("n", "[d", vim.diagnostic.goto_prev, opts)
		map("n", "]d", vim.diagnostic.goto_next, opts)
		map("n", "[)", vim.diagnostic.goto_prev, opts)
		map("n", "])", vim.diagnostic.goto_next, opts)
		map("n", "<space>q", vim.diagnostic.setloclist, opts)

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
		map("n", "<space>T", vim.lsp.buf.type_definition, opts)
		map("n", "<space>n", vim.lsp.buf.rename, opts)
		map("n", "<space>c", vim.lsp.buf.code_action, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<space>g", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local default_settings = {
	onattach = onattach,
	autostart = false,
	capabilities = capabilities,
	settings = {},
}
--
-- https://gist.github.com/tylerneylon/81333721109155b2d244
function copy1(obj)
	if type(obj) ~= "table" then
		return obj
	end
	local res = {}
	for k, v in pairs(obj) do
		res[copy1(k)] = copy1(v)
	end
	return res
end

local yapf = require("efmls-configs.formatters.yapf")
local stylua = require("efmls-configs.formatters.stylua")

local languages = {
	python = { yapf },
	lua = { stylua },
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	autostart = true,
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup(copy1(default_settings))
	end,

	["efm"] = function()
		local settings = vim.tbl_extend("keep", efmls_config, copy1(default_settings))
		-- print(vim.inspect(settings))
		require("lspconfig")["efm"].setup(settings)
	end,

	["rust_analyzer"] = function()
		local settings = copy1(default_settings)
		settings.server = {
			["rust-analyzer"] = {
				check = {
					allTargets = true,
				},
			},
		}
		require("rust-tools").setup(settings)
	end,

	["julials"] = function()
		local settings = copy1(default_settings)
		settings.filetypes = { "julia", "jl" }
		require("lspconfig")["julials"].setup(settings)
	end,

	["lua_ls"] = function()
		local settings = copy1(default_settings)
		settings.settings["Lua"] = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
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

require("crates").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.set_config({
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged,InsertLeave",
	ft_func = require("luasnip.extras.filetype_functions").from_cursor,
	history = true,
	region_check_events = "CursorMoved,CursorHold,InsertEnter",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snips" })

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
	Class = "",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "󰡱",
	Interface = "",
	Keyword = "",
	Method = "m",
	Module = "",
	Operator = "",
	Property = "",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "󰊄",
	TypeParameter = "",
	Unit = "",
	Value = "󰰪",
	Variable = "󰫧",
}

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				nvim_lsp_signature_help = "[Sig]",
				calc = "[#]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				crates = "[Crates]",
				omni = "[Omni]",
			})[entry.source.name]
			return vim_item
		end,
	},
	window = {},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		-- ["<CR>"] = cmp.mapping.confirm { select = false },
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()

			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "async_path" },
		{ name = "luasnip" },
		{ name = "crates" },
		{ name = "buffer" },
	}),
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	},
	-- experimental = {
	-- 	ghost_text = true,
	-- 	native_menu = false,
	-- },
})

cmp.setup.filetype({ "tex" }, {
	-- experimental = {
	-- 	ghost_text = true,
	-- 	native_menu = false,
	-- },
	completion = {
		autocomplete = false,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
				buffer = "[Buffer]",
				-- formatting for other sources
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "omni" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "async_path" },
	},
})

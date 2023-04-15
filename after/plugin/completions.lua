local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.set_config({
     enable_autosnippets = true,
     store_selection_keys = "<Tab>",
     update_events = "TextChanged,TextChangedI",
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snips" })

local has_words_before = function()
local col = vim.fn.col "." - 1
return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end


local kind_icons = {
Class = "",
Color = "",
Constant = "",
Constructor = "",
Enum = "",
EnumMember = "",
Event = "",
Field = "",
File = "",
Folder = "",
Function = "",
Interface = "",
Keyword = "",
Method = "m",
Module = "",
Operator = "",
Property = "",
Reference = "",
Snippet = "",
Struct = "",
Text = "",
TypeParameter = "",
Unit = "",
Value = "",
Variable = "",
}

cmp.setup({
snippet = {
     expand = function(args)
     require('luasnip').lsp_expand(args.body)
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
          fuzzy_buffer = "[Buffer]",
          nvim_lsp_signature_help = "[SIG]",
          calc = "[#]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          crates = "[Crates]",
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
     ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
     },
     -- Accept currently selected item. If none selected, `select` first item.
     -- Set `select` to `false` to only confirm explicitly selected items.
     ["<CR>"] = cmp.mapping.confirm { select = false },
     ["<Tab>"] = cmp.mapping(function(fallback)
     if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
     elseif luasnip.expand_or_jumpable() then
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
}, sources = cmp.config.sources({
{ name = "path" },
{ name = "nvim_lsp" },
{ name = "nvim_lsp_signature_help" },
{ name = "luasnip" },
{ name = "crates" },
{ name = "buffer" },
{ name = "calc" },
}),
confirm_opts = {
behavior = cmp.ConfirmBehavior.Replace,
select = true,
},
experimental = {
ghost_text = true,
native_menu = false,
},
})

cmp.setup.filetype({ "tex" }, {
    mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },
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
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "crates" },
        { name = "buffer" },
        { name = "calc" },
    }),
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
    completion = {
        autocomplete = false,
    },
})


require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lsp_status = require('lsp-status')

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)

lsp_status.config({
    indicator_errors = ' ',
    indicator_warnings = ' ',
    indicator_info = ' ',
    indicator_hint = ' ',
    indicator_ok = ' ',
    show_filename = false,
    current_function = true,
})

lsp_status.register_progress()

local onattach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    lsp_status.on_attach(client)
end

local default_settings = {
    onattach = onattach,
    autostart = false,
    capabilities = capabilities,
}

local lsps = {
    "sumneko_lua",
    "rust_analyzer",
    "gopls",
    "clangd",
    "taplo",
    "texlab",
    "pyright",
    "cmake",
    "julials",
}

-- https://gist.github.com/tylerneylon/81333721109155b2d244
function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end

local lsp_settings = {}

for _, k in ipairs(lsps) do
    lsp_settings[k] = copy1(default_settings)
end

lsp_settings["rust_analyzer"].server = { standalone = true }
lsp_settings["julials"].filetypes = { "julia", "jl" }

local lsp_config = require('lspconfig')
for k, v in pairs(lsp_settings) do
    if k == "rust_analyzer" then
        require('rust-tools').setup({
            server = v,
        })
    else
        lsp_config[k].setup(v)
    end
end

require('crates').setup()

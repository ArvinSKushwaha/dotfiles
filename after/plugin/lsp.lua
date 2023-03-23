require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true
})
require("mason-null-ls").setup({
    automatic_setup = true,
})
require("mason-nvim-dap").setup({
    automatic_setup = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)

local onattach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- lsp_status.on_attach(client)
end

local default_settings = {
    onattach = onattach,
    autostart = false,
    capabilities = capabilities,
    settings = {},
}
--
-- https://gist.github.com/tylerneylon/81333721109155b2d244
function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end

require("mason-lspconfig").setup_handlers {
    function (server_name)
        require('lspconfig')[server_name].setup(copy1(default_settings))
    end,

    ["rust_analyzer"] = function()
        local settings = copy1(default_settings)
        settings["cmd"] = { "ra-multiplex" }
        settings.settings["rust_analyzer"] = {
            check = {
                overrideCommand = {
                    "cargo", "clippy", "--message-format=json-diagnostic-rendered-ansi", "--fix", "--allow-dirty",
                }
            }
        }
        require('rust-tools').setup(v)
    end,

    ["julials"] = function()
        local settings = copy1(default_settings)
        settings.filetypes = { "julia", "jl" }
        require('lspconfig')["julials"].setup(settings)
    end,

    ["lua_ls"] = function()
        local settings = copy1(default_settings)
        settings.settings["Lua"] = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
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
        require('lspconfig')["lua_ls"].setup(settings)
    end
}

require('mason-null-ls').setup_handlers {
    function(source_name, methods)
      require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
}

require 'mason-nvim-dap'.setup_handlers {
}

require('null-ls').setup()
require('crates').setup()

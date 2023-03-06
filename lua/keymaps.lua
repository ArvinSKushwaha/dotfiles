local map = vim.keymap.set;
local telescope_builtin = require('telescope.builtin')

vim.g.mapleader = " "

----------------
--[[ Motion ]] --
----------------

map("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })
map("v", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
map("v", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })

map("n", "<C-a>", "ggVG", {})
map("n", "<C-c>", ":%y<CR>", {})

----------------
--[[ Packer ]] --
----------------
map('n', '<leader>u', ":PackerSync<CR>", {})

-------------------
--[[ Nvim Tree ]] --
-------------------
map('n', '<leader>o', require('nvim-tree.api').tree.toggle, {})

----------------
--[[ Tagbar ]]--
----------------

map('n', '<F8>', ':TagbarToggle<CR>', {})

-------------------
--[[ Telescope ]] --
-------------------

map('n', '<leader>ff', telescope_builtin.find_files, {})
map('n', '<leader>fg', function()
    -- If the directory is not a git repository, fallback to regular find_files.
    if pcall(telescope_builtin.git_files) then
    else
        pcall(telescope_builtin.find_files)
    end
end, {})
map('n', '<leader>fs', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, {})
map('n', '<leader>T', telescope_builtin.builtin, {})

--------------
--[[ LSP ]] --
--------------

map('n', ';l', ":LspStart<CR>", {})
map('n', ';s', ":LspStop<CR>", {})
map('n', ';r', ":LspRestart<CR>", {})

-----------------
--[[ Vimtex ]] --
-----------------

map('n', '<leader>vv', ":VimtexCompile<CR>", {})

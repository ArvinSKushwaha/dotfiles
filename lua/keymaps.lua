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
map('n', ';i', ":LspInfo<CR>", {})

-----------------
--[[ Vimtex ]] --
-----------------

map('n', '<leader>vv', ":VimtexCompile<CR>", {})

-------------------
--[[ Undo Tree ]]--
-------------------

map('n', '<F5>', ':UndotreeToggle<CR>', {})

--------------------
--[[ Vimspector ]]--
--------------------

map('n', '<A-l>', ':call vimspector#Launch()<CR>', {})
map('n', '<A-s>', ':call vimspector#StepOver()<CR>', {})
map('n', '<A-r>', ':call vimspector#Reset()<CR>', {})
map('n', '<A-o>', ':call vimspector#StepOut()<CR>', {})
map('n', '<A-i>', ':call vimspector#StepInto()<CR>', {})

map('n', '<A-b>', ':call vimspector#ToggleBreakpoint()<CR>', {})
map('n', '<A-w>', ':call vimspector#AddWatch<CR>', {})
map('n', '<A-e>', ':call vimspector#Evaluate<CR>', {})

-------------
--[[ Hop ]]--
-------------

map('n', '<C-h>', ':HopLine<CR>', {})
map('n', '<C-H>', ':HopAnywhere<CR>', {})
map('n', '<C-j>', ':HopPattern<CR>', {})

-----------------
--[[ Trouble ]]--
-----------------

map('n', '<leader>xx', '<cmd>Trouble workspace_diagnostics<cr>', {noremap = true})
map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', {noremap = true})
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>', {noremap = true})
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', {noremap = true})

-----------------
--[[ LazyGit ]]--
-----------------

map('n', '<leader>lg', '<cmd>LazyGit<cr>', {silent = true})

-----------------
--[[ Neovide ]]--
-----------------

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)

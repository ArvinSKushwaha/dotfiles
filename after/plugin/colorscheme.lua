require("catppuccin").setup({})

vim.cmd.colorscheme('catppuccin')

local ctp_feline = require('catppuccin.groups.integrations.feline')

ctp_feline.setup({})

require("feline").setup({
    components = ctp_feline.get({}),
})


require("feline").winbar.setup({ })


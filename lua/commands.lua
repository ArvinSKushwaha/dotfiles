local map = vim.keymap.set
local unmap = vim.keymap.del

local mapall = function(trigger, action, opts)
    map('n', trigger, action, opts)
    map('v', trigger, action, opts)
    map('i', trigger, action, opts)
end
local mapforall = function(triggers, action, opts)
    for _, trigger in ipairs(triggers) do
        mapall(trigger, action, opts)
    end
end

local unmapall = function(trigger)
    unmap('n', trigger)
    unmap('v', trigger)
    unmap('i', trigger)
end
local unmapforall = function(triggers)
    for _, trigger in ipairs(triggers) do
        unmapall(trigger)
    end
end

vim.api.nvim_create_user_command(
    'DisableArrowKeys',
    function()
        mapforall({ '<left>', '<right>', '<up>', '<down>' }, '<nop>', {})

        map('n', '<left>', ':vertical resize +2<CR>', {})
        map('n', '<right>', ':vertical resize -2<CR>', {})
        map('n', '<up>', ':resize +2<CR>', {})
        map('n', '<down>', ':resize -2<CR>', {})
    end,
    { bang = true, desc = 'Make life harder' }
)

vim.api.nvim_create_user_command(
    'EnableArrowKeys',
    function()
        unmapforall({ '<left>', '<right>', '<up>', '<down>' })
    end,
    { bang = true, desc = 'Make life easier' }
)

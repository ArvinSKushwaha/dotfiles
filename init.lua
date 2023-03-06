local function load(module)
	local status, err = pcall(function() require(module) end)
	if not status then
		print(err)
	else end
end

-- Load options before anything else
load('options');

load('plugins');
load('keymaps');
load('commands');

vim.cmd [[DisableArrowKeys]]

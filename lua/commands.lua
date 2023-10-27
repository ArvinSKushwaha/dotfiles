vim.api.nvim_create_user_command("LoadToday", function()
	local date = os.date("*t")
	vim.cmd(
		string.format(
			"tabnew ~/Nextcloud/arvim/Journal/%04d/%02d/%04d-%02d-%02d.md",
			date.year,
			date.month,
			date.year,
			date.month,
			date.day
		)
	)
end, { bang = true, desc = "Loads today" })

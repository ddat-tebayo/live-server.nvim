local M = {}

M.default_config = {
	liveserver_args = {},
}

M.start = function()
end

M.stop = function()
end

M.toggle = function()
end

M.setup = function(user_config)
	M.default_config = vim.tbl_deep_extend( "force", M.default_config, user_config or {})

	vim.api.nvim_create_user_command("LiveServerStart", M.start, {})
	vim.api.nvim_create_user_command("LiveServerStop", M.stop, {})
	vim.api.nvim_create_user_command("LiveServerToggle", M.toggle, {})
end

return M

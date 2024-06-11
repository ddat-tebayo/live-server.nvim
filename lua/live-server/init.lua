local utils = require("live-server.utils")

local M = {}

M.default_config = {
	liveserver_args = {},
}

M.start = function()
	local dir = vim.fn.expand("%:p:h")

	if utils.is_running() then
		utils.log("live-server already running", "WARN")
		return
	end

	local cmd = { "live-server", dir }
	vim.list_extend(cmd, M.default_config.liveserver_args)

	local SERVER_JOB = vim.fn.jobstart(cmd, {
		on_stdout = function(_, data)
			-- Remove ANSI escape sequences
			local output = table.concat(data)
			local strippedOutput = output:gsub("\27%[%d;*%d*([mK])", "")
			if string.match(strippedOutput, "http") then
				utils.log(strippedOutput, "INFO")
			end
		end,
	})
	utils.job_cache[dir] = SERVER_JOB
end

M.stop = function()
	if utils.is_running() then
		local cached_dir = utils.find_cached_dir()
		if cached_dir then
			vim.fn.jobstop(utils.job_cache[cached_dir])
			utils.job_cache[cached_dir] = nil
			utils.log("live-server stopped", "INFO")
		end
	else
		utils.log("live-server not running", "WARN")
		return
	end
end

M.toggle = function()
	if not utils.is_running() then
		M.start()
		return
	end
	M.stop()
end

M.setup = function(user_config)
	M.default_config = vim.tbl_deep_extend("force", M.default_config, user_config or {})

	if not vim.fn.executable("live-server") then
		utils.log("live-server is not executable. Ensure the npm module is properly installed", "ERROR")
		return
	end

	vim.api.nvim_create_user_command("LiveServerStart", M.start, {})
	vim.api.nvim_create_user_command("LiveServerStop", M.stop, {})
	vim.api.nvim_create_user_command("LiveServerToggle", M.toggle, {})
end

return M

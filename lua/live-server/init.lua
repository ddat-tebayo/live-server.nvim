local log = function(message, level)
	vim.notify(string.format("live-server.nvim: %s", message), vim.log.levels[level])
end

local job_cache = {}

local find_cached_dir = function()
    local cur = vim.fn.expand '%:p:h'
    while not job_cache[cur] do
        if cur == '/' then
            return
        end
        cur = vim.fn.fnamemodify(cur, ':h')
    end

    return cur
end

local is_running = function()
    local cached_dir = find_cached_dir()
    return cached_dir and job_cache[cached_dir]
end

local M = {}

M.default_config = {
    liveserver_args = {},
}


M.start = function()
    local dir = vim.fn.expand '%:p:h'

    if is_running() then
        log('live-server already running', 'WARN')
        return
    end

	local cmd = { 'live-server', dir }
    vim.list_extend(cmd, M.default_config.liveserver_args)

	local SERVER_JOB = vim.fn.jobstart(cmd, { 
		on_stdout = function(_, data)
			-- Remove ANSI escape sequences
			local output = table.concat(data)
			local strippedOutput = output:gsub("\27%[%d;*%d*([mK])", "")
			if string.match(strippedOutput, "http") then
				log(strippedOutput, 'INFO')
			end
		end,

	})
	job_cache[dir] = SERVER_JOB
end

M.stop = function()
    if is_running() then
        local cached_dir = find_cached_dir()
        if cached_dir then
            vim.fn.jobstop(job_cache[cached_dir])
            job_cache[cached_dir] = nil
            log('live-server stopped', 'INFO')
        end
    else
        log('live-server not running', 'WARN')
    end
    return
end

M.toggle = function()
end

M.setup = function(user_config)
	M.default_config = vim.tbl_deep_extend( "force", M.default_config, user_config or {})

	if not vim.fn.executable 'live-server' then
		log("live-server is not executable. Ensure the npm module is properly installed", 'ERROR')
		return
	end

	vim.api.nvim_create_user_command("LiveServerStart", M.start, {})
	vim.api.nvim_create_user_command("LiveServerStop", M.stop, {})
	vim.api.nvim_create_user_command("LiveServerToggle", M.toggle, {})
end

return M

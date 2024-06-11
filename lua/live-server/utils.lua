local M = {}

M.log = function(message, level)
	vim.notify(string.format("live-server.nvim: %s", message), vim.log.levels[level])
end

M.job_cache = {}

M.find_cached_dir = function()
	local cur = vim.fn.expand("%:p:h")
	while not M.job_cache[cur] do
		if cur == "/" then
			return
		end
		cur = vim.fn.fnamemodify(cur, ":h")
	end
	return cur
end

M.is_running = function()
	local cached_dir = M.find_cached_dir()
	return cached_dir and M.job_cache[cached_dir]
end

return M

local liveServer = require("live-server")
local utils = require("live-server.utils")
local lualine_cfg = require("live-server").default_config.integration.lualine

local get_liveserver_color = function()
	local fg = lualine_cfg.colors.disconnected
	if utils.is_running() then
		fg = lualine_cfg.colors.connected
	end
	return { fg = fg }
end

local get_liveserver_icon = function()
	local icon
	if utils.is_running() then
		icon = lualine_cfg.icons.connected .. " :" .. liveServer.port
	else
		icon = lualine_cfg.icons.disconnected .. " "
	end
	return icon
end

local liveserver_supported_ft = function()
	local supported_ft = lualine_cfg.supported_filetypes
	return vim.tbl_contains(supported_ft, vim.bo.filetype)
end

return {
	function()
		return get_liveserver_icon()
	end,
	color = function()
		return get_liveserver_color()
	end,
	cond = function()
		return liveserver_supported_ft()
	end,
	on_click = function()
		liveServer.toggle()
	end,
}

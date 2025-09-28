-- put this file .config/nvim/lua/custom/plugins/ for Lazy.nvim

return {
	-- "nagaduki/bgimg",
	dir = "~/Projects/git/bgimg/", 
	-- lazy=false,
	config = {
		message = "this is bgimg plugin.",
		wez_history_file = "/mnt/c/Users/August/.config/wezterm/config/history.lua",
		wez_config_file = "/mnt/c/Users/August/.config/wezterm/config/background.lua",
	},
	--[[
	cmd = {
		"Bglight",
		"Bgdark",
	}
	]]
}

-- main module file
-- local module = require("plugin_name.module")
local module = require("bgimg.module")
local BackGroundManager = require("bgimg.util.BackGroundManager")

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",

  -- TEST
  message = "hello git world from lua script.",
  first_name = "yamada",
  nick_name = "gitman",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  -- TEST
  -- print(M.config.message)
  -- print(M.config.wez_history_file)
  -- print(M.config.wez_config_file)
  BackGroundManager.set_history_file(M.config.wez_history_file)
  BackGroundManager.set_config_file(M.config.wez_config_file)
  vim.api.nvim_create_user_command("HelloName", M.hello_name, {})
  vim.api.nvim_create_user_command("HelloNick", M.hello_nick, {})
  vim.api.nvim_create_user_command("Bglight", M.set_background_hsb_brightness_light, {})
  vim.api.nvim_create_user_command("Bgdark", M.set_background_hsb_brightness_dark, {})
  vim.api.nvim_create_user_command("Bgleft", M.set_background_horizontal_align_left, {})
  vim.api.nvim_create_user_command("Bgright", M.set_background_horizontal_align_right, {})
  vim.api.nvim_create_user_command("Bgcenter", M.set_background_horizontal_align_center, {})
  vim.api.nvim_create_user_command("Bgzoom", M.set_background_zoom, { nargs = 1 })
  vim.api.nvim_create_user_command("Bgtop", M.set_background_vertical_align_top, {})
  vim.api.nvim_create_user_command("Bgbottom", M.set_background_vertical_align_bottom, {})
  vim.api.nvim_create_user_command("Bgmiddle", M.set_background_vertical_align_middle, {})
  vim.api.nvim_create_user_command("Bgconfig", M.print_config, {})
end

M.hello = function()
  return module.my_first_function(M.config.opt)
end

M.print_config = function()
  print("wezterm history file: " .. M.config.wez_history_file)
  print("wezterm wezterm config file: " .. M.config.wez_config_file)
end

-- print("hello git world.")
M.hello_name = function()
  print(M.config.message .. M.config.first_name)
  -- BackGroundManager.Light()
end

M.hello_nick = function()
  print(M.config.message .. M.config.nick_name)
  -- BackGroundManager.Dark()
end

M.set_background_hsb_brightness_light = function()
  BackGroundManager.load()
  BackGroundManager.light()
  BackGroundManager.flush()
end

M.set_background_hsb_brightness_dark = function()
  BackGroundManager.load()
  BackGroundManager.dark()
  BackGroundManager.flush()
end

M.set_background_horizontal_align_left = function()
  BackGroundManager.load()
  BackGroundManager.set_horizontal_align("Left")
  BackGroundManager.flush()
end

M.set_background_horizontal_align_right = function()
  BackGroundManager.load()
  BackGroundManager.set_horizontal_align("Right")
  BackGroundManager.flush()
end

M.set_background_horizontal_align_center = function()
  BackGroundManager.load()
  BackGroundManager.set_horizontal_align("Center")
  BackGroundManager.flush()
end

M.set_background_zoom = function(opts)
  local mg_ratio = opts.fargs[1] or 1.0
  BackGroundManager.load()
  BackGroundManager.zoom(mg_ratio)
  BackGroundManager.flush()
end

M.set_background_vertical_align_top = function()
  BackGroundManager.load()
  BackGroundManager.set_vertical_align("Top")
  BackGroundManager.flush()
end

M.set_background_vertical_align_bottom = function()
  BackGroundManager.load()
  BackGroundManager.set_vertical_align("Bottom")
  BackGroundManager.flush()
end

M.set_background_vertical_align_middle = function()
  BackGroundManager.load()
  BackGroundManager.set_vertical_align("Middle")
  BackGroundManager.flush()
end

return M

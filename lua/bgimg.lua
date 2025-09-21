-- main module file
-- local module = require("plugin_name.module")
local module = require("bgimg.module")

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
  print(M.config.message)
  vim.api.nvim_create_user_command('HelloName', M.hello_name, {})
  vim.api.nvim_create_user_command('HelloNick', M.hello_nick, {})
end

M.hello = function()
  return module.my_first_function(M.config.opt)
end

-- print("hello git world.")
M.hello_name = function()
	print(M.config.message .. M.config.first_name)
end

M.hello_nick = function()
	print(M.config.message .. M.config.nick_name)
end

return M

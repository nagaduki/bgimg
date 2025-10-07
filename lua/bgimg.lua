-- main module file
-- local module = require("plugin_name.module")
-- local module = require("bgimg.module")
local BackGroundManager = require("bgimg.util.BackGroundManager")
local OCR = require("bgimg.util.OCR")
local Path = require("bgimg.util.Path")
local Widget = require("bgimg.util.Widget")
local Table = require("bgimg.core.Table")
local widget = require("bgimg.widget")

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
  vim.api.nvim_create_user_command("Bgocr", M.ocr, {})
  vim.api.nvim_create_user_command("Bgstatus", M.print_status, {})
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

M.print_status = function()
  print("windows status.")
  print("columns: " .. vim.api.nvim_get_option("columns"))
  print("liness: " .. vim.api.nvim_get_option("lines"))
end

M.ocr = function()
  --
  BackGroundManager.load()
  local source_file = BackGroundManager.get_source_file()
  local wsl_path = Path.convert_wsl_path(source_file)
  local text_path = Path.change_ext(wsl_path, "txt")

  OCR.set_image_path(wsl_path)

  if not Path.exit(text_path) then
    OCR.convert_to_file(text_path)
  end

  local lines_table = Table.create_lines(text_path)

  local win_width = math.floor(vim.api.nvim_get_option("columns") * 4 / 5)
  local wrap_count = widget.lines.wrap_count(lines_table, win_width)
  local win_height = math.min(#lines_table, math.floor(vim.api.nvim_get_option("lines") * 4 / 5)) + wrap_count

  -- print("wrap count: " .. wrap_count)
  -- print("width: " .. win_width)
  -- print("height: " .. win_height)

  -- widget.string.width("ABC")

  local opts = {
    title = { { text_path, "InputFloatTitle" } },
    title_pos = "center",
    relative = "editor", -- Position relative to the editor
    --[[
    width = 50,
    height = 30,
		]]
    width = win_width,
    height = win_height,
    -- height = math.min(#lines_table, math.floor(vim.api.nvim_get_option("lines") * 4 / 5)) + 5,
    -- height = math.min(#lines_table, math.floor(vim.api.nvim_get_option("lines") * 4 / 5)) + 5,

    --[[
    row = math.floor((vim.api.nvim_get_option("lines") - 10) / 2), -- Center vertically
    col = math.floor((vim.api.nvim_get_option("columns") - 10) / 2), -- Center horizontally
		]]
    row = 2, -- Center vertically
    col = math.floor(vim.api.nvim_get_option("columns") * 1 / 10), -- Center horizontally
    border = "rounded", -- Optional: "single", "double", "rounded", "solid", "none"
    -- style = "minimal", -- Optional: "minimal" for no statusline/tabline
    focusable = true,
    zindex = 100, -- Bring the window to the front
  }

  local window_id, buffer
  if win_height == 0 then
    -- Todo. error window
    print("error: check network, and remove empty file.")
  else
    window_id, buffer = Widget.floating_window(text_path, opts)
  end
  -- vim.api.nvim_buf_set_name(buffer, text_path)

  -- dont work
  -- vim.api.nvim_buf_set_name(buffer, text_path)
  -- vim.api.nvim_buf_set_option(buffer, "bufname", text_path)
  -- vim.keymap.set("c", "w", "<cmd>w " .. text_path .. "<cr>", { buffer = buffer, silent = true })
  --[[ --
  vim.keymap.set(
    "c",
    "w",
    "<cmd>write! " .. text_path .. "<cr><cmd>quit<cr>",
    { buffer = buffer, silent = true, noremap = true }
  )
	--]]
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines_table)
  -- vim.api.nvim_buf_call(buffer, vim.cmd.edit)

  local buffer_exist = false
  for num, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    -- print("name:" .. name)
    if vim.api.nvim_buf_get_name(buf) == text_path then
      -- buffer = buf
      -- table.insert(buffers_to_keep, buf)
      -- vim.api.nvim_buf_call(buf, vim.cmd.edit)
      -- local name = vim.api.nvim_buf_get_option(buf, "name")
      -- print("name:" .. name)
      -- print("num: " .. num)
      -- print("buf: " .. buf)
      buffer_exist = true
      -- pcall(vim.api.nvim_buf_delete, buf, { force = false })
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end

  if not buffer_exist then
    -- print("buffer has no name. set " .. text_path)
    -- print("nvim_buf_get_name: " .. vim.api.nvim_buf_get_name(buffer))
    vim.api.nvim_buf_set_name(buffer, text_path)
  else
    -- print("nvim_buf_get_name: " .. vim.api.nvim_buf_get_name(buffer))
    -- vim.api.nvim_buf_set_name(buffer, text_path)
  end

  -- vim.keymap.set("c", "q", "<cmd>q!<cr>", { buffer = buffer, silent = true, noremap = true })

  -- vim.api.nvim_buf_del_mark(buffer, ".")
end

return M

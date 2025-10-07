local Logger = require("bgimg.util.Logger")
local P = require("bgimg.util.P") -- custom print function
local Path = require("bgimg.util.Path")
local Image = require("bgimg.util.Image") -- custom print function

local M = {}

M = {
  -- source_file    = "";
  -- old_image_path = "";
  __current_source_file = "",
  __history_file = "/mnt/c/Users/August/.config/wezterm/config/history.lua",
  __content_table = nil,
  __config_path = "/mnt/c/Users/August/.config/wezterm/config/background.lua",
  __history_table = nil,
  --__config_path  = "/mnt/c/Users/August/.config/wezterm/config/_background.lua";

  Add_history = function(windows_path)
    local history_list = M.__history_table.list or {}
    -- history.table.insert( windows_path, history )
    if windows_path == history_list[1] then
      return
    end

    table.insert(history_list, 1, windows_path)
  end,

  Back_history = function()
    local history_list = M.__history_table.list or {}
    local history_current = M.__history_table.current or 1
    local history_size = #history_list
    if history_size == history_current then
      return
    end

    -- history_current = history_current + 1
    -- history_current = 2
    M.__history_table.current = history_current + 1
    P(" history_current in Back function: " .. history_current)
    M.__current_source_file = history_list[history_current]
    P(" set image file in Back function: " .. history_list[history_current])
    P("[history_table]")
    Logger.Info(M.__history_table)
  end,

  Forward_history = function()
    local history_list = M.__history_table.list or {}
    local history_current = M.__history_table.current or 1
    local history_size = #history_list
    if history_current == 1 then
      return
    end

    history_current = history_current - 1
    P(" history_current in Forward function: " .. history_current)
    M.__current_source_file = history_list[history_current]
  end,

  Curr_history = function()
    local history_current = M.__history_table.current or 1
    return history_current
  end,

  Flush_history = function(history_file_path)
    local history = M.__history_table
    local update_history_file_path = history_file_path
    local serialized_history = M.__dump_table(history, "")
    local update_timestamp = "-- " .. Now()
    --__history_file  = "/mnt/c/Users/August/.config/wezterm/config/history.lua";
    local update_history_file, err = assert(io.open(update_history_file_path, "w"))

    if not update_history_file then
      update_history_file:close()
    else
      update_history_file:write(update_timestamp .. "\n")
      update_history_file:write("return ")
      update_history_file:write(serialized_history)
      update_history_file:write("\n")
      update_history_file:close()
    end
  end,

  -- for debug
  --[[
  Get_content = function()
    return M.__content_table
  end,

  Set_vertical_align = function(align)
    local config = M.__content_table
    config.background[1].vertical_align = align
  end,

  Get_vertical_align = function()
    local config = M.__content_table
    return config.background[1].vertical_align
  end,

  Set_horizontal_align = function(align)
    local config = M.__content_table
    config.background[1].horizontal_align = align
  end,

  Get_horizontal_align = function()
    local config = M.__content_table
    return config.background[1].horizontal_align
  end,

  Set_height = function(height)
    local config = M.__content_table
    config.background[1].height = height
  end,

  Get_height = function()
    local config = M.__content_table
    return config.background[1].height
  end,

  Set_width = function(width)
    local config = M.__content_table
    config.background[1].width = width
  end,

  Get_width = function()
    local config = M.__content_table
    return config.background[1].width
  end,
--]]
  ----

  get_content = function()
    return M.__content_table
  end,

  set_vertical_align = function(align)
    local config = M.__content_table
    config.background[1].vertical_align = align
  end,

  get_vertical_align = function()
    local config = M.__content_table
    return config.background[1].vertical_align
  end,

  set_horizontal_align = function(align)
    local config = M.__content_table
    config.background[1].horizontal_align = align
  end,

  get_horizontal_align = function()
    local config = M.__content_table
    return config.background[1].horizontal_align
  end,

  set_height = function(height)
    local config = M.__content_table
    config.background[1].height = height
  end,

  get_height = function()
    local config = M.__content_table
    return config.background[1].height
  end,

  set_width = function(width)
    local config = M.__content_table
    config.background[1].width = width
  end,

  get_width = function()
    local config = M.__content_table
    return config.background[1].width
  end,

  --[[
  set_config_file = function(width)
    local config = M.__content_table
  end,
]]

  set_history_file = function(path)
    M.__history_file = path
  end,

  set_config_file = function(path)
    M.__config_path = path
  end,

  --[[
  Zoom = function(ratio)
    local config = M.__content_table
    local source_file = string.format("%q", config.background[1].source.File)
    local wsl_path = Path.Convert_wsl_path(M.__current_source_file)
    local image = Image.new(wsl_path)
    config.background[1].width = math.floor(tonumber(image.width) * ratio)
    config.background[1].height = math.floor(tonumber(image.height) * ratio)
  end,

  Light = function()
    local config = M.__content_table
    config.background[1].hsb.brightness = 0.95
  end,

  Dark = function()
    local config = M.__content_table
    config.background[1].hsb.brightness = 0.1
  end,

  -- set wezterm config source file
  -- @param   path windows path
  -- @return  void
  Set_source_file = function(windows_path)
    --P( " ------------------ Set_source_file ------------------ " )
    --P( " ----------------------------------------------------- " )
    local config = M.__content_table
    local history_list = M.__history_table.list or {}
    local history_current = M.__history_table.current or 1
    -- Logger.Info ( M.__content_table )

    -- for get image status
    local wsl_path = Path.Convert_wsl_path(windows_path)
    -- Logger.Info( wsl_path )
    -- Logger.Info( windows_path )

    local image = Image.new(wsl_path)
    local height = image.height .. "px"
    local width = image.width .. "px"
    local type = image.type

    -- Logger.Info( " " .. image.height .. ", " .. image.width .. " " )
    -- update
    -- M.source_file = windows_path
    config.background[1].height = height
    config.background[1].width = width
    config.background[1].source.File = windows_path
    M.__current_source_file = windows_path
    -- table.history_currentinsert ( history, 1, windows_path )
    if history_current > 1 then
      for i = 1, history_current - 1 do
        P(" remove table list : " .. i)
        table.remove(history_list, i)
      end
    end

    M.__history_table.current = 1

    M.Add_history(windows_path)
    --P( " ------------------ Set_source_file dump ------------------ " )
    Logger.Info(history_list)
    -- P( " ------------------ Set_source_file serialized ------------------ " )
    -- P( M.__dump_table( history, "" ) )
    -- P( " ------------------ Set_source_file over ------------------ " )
    -- config.background[1].type   = type
    -- Logger.Info ( "---- after set ----" )
    -- Logger.Info ( M.__content_table )
  end,

  -- get wezterm config source file
  -- @param   void
  -- @return  path windows path
  Get_source_file = function()
    if not M.__content_table then
      return nil
    end

    local config = M.__content_table
    Logger.Info(self)
    return config.background[1].source.File
  end,

  Release = function()
    if not M.__content_table then
      M.__content_table = nil
    end
    if not M.__history_table then
      M.__history_table = nil
    end
  end,
	

  -- get wezterm config source file
  -- @param   void
  -- @return  path windows path
  Load = function()
    if M.__content_table then
      return M.__content_table
    end
    M.__content_table = dofile(M.__config_path)
    M.__history_table = dofile(M.__history_file)
    local config = M.__content_table
    local history = M.__history_table
    M.__current_source_file = config.background[1].source.File
  end,

  Dump = function()
    Logger.Info(M.__content_table)
  end,

  -- saving wezterm config background.lua";
  -- @param   void
  -- @return  void
  Save = function()
    -- local data = dofile( M.__config_path )
    local config = M.__content_table
    local serialized_data

    -- return dump_table ( data, "" );
    serialized_data = M.__dump_table(config, "")

    -- update config file
    local content_root = "config"

    local update_file, err = assert(io.open(M.__config_path, "w"))
    local update_timestamp = "-- " .. M.Now()

    if not update_file then
      update_file:close()
    else
      update_file:write(update_timestamp .. "\n")
      update_file:write("local config={}\n")
      update_file:write(content_root .. "=" .. serialized_data)
      update_file:write("\n")
      update_file:write("return config\n")
      update_file:close()
    end

    M.__content_table = nil
    M.__history_table = nil
  end,

  -- saving wezterm config background.lua";
  -- @param   void
  -- @return  void
  Flush = function()
    -- local data = dofile( M.__config_path )
    local config = M.__content_table
    local history = M.__history_table
    local serialized_content = M.__dump_table(config, "")
    local serialized_history = M.__dump_table(history, "")

    -- update config file
    local content_root = "config"

    local update_file_path = M.__config_path
    local update_file, err = assert(io.open(update_file_path, "w"))
    local update_timestamp = "-- " .. M.Now()

    if not update_file then
      update_file:close()
    else
      update_file:write(update_timestamp .. "\n")
      update_file:write("local config={}\n")
      update_file:write(content_root .. "=" .. serialized_content)
      update_file:write("\n")
      update_file:write("return config\n")
      update_file:close()
    end
    M.Flush_history(M.__history_file)
  end,
	]]
}

function M.add_history(windows_path)
  local history_list = M.__history_table.list or {}
  if windows_path == history_list[1] then
    return
  end
  table.insert(history_list, 1, windows_path)
end

function M.back_history()
  local history_list = M.__history_table.list or {}
  local history_current = M.__history_table.current or 1
  local history_size = #history_list
  if history_size == history_current then
    return
  end
  M.__history_table.current = history_current + 1
  M.__current_source_file = history_list[history_current]
end

function M.forward_history()
  local history_list = M.__history_table.list or {}
  local history_current = M.__history_table.current or 1
  local history_size = #history_list
  if history_current == 1 then
    return
  end
  history_current = history_current - 1
  M.__current_source_file = history_list[history_current]
end

function M.curr_history()
  local history_current = M.__history_table.current or 1
  return history_current
end

function M.flush_history(history_file_path)
  local history = M.__history_table
  local update_history_file_path = history_file_path
  local serialized_history = M.__dump_table(history, "")
  local update_timestamp = "-- " .. Now()
  local update_history_file, err = assert(io.open(update_history_file_path, "w"))

  if not update_history_file then
    update_history_file:close()
  else
    update_history_file:write(update_timestamp .. "\n")
    update_history_file:write("return ")
    update_history_file:write(serialized_history)
    update_history_file:write("\n")
    update_history_file:close()
  end
end

function M.zoom(ratio)
  local config = M.__content_table
  local source_file = string.format("%q", config.background[1].source.File)
  local wsl_path = Path.convert_wsl_path(M.__current_source_file)
  local image = Image.new(wsl_path)
  config.background[1].width = math.floor(tonumber(image.width) * ratio)
  config.background[1].height = math.floor(tonumber(image.height) * ratio)
end

function M.light()
  local config = M.__content_table
  config.background[1].hsb.brightness = 0.95
end

function M.dark()
  local config = M.__content_table
  config.background[1].hsb.brightness = 0.1
end

function M.set_source_file(windows_path)
  local config = M.__content_table
  local history_list = M.__history_table.list or {}
  local history_current = M.__history_table.current or 1
  local wsl_path = Path.convert_wsl_path(windows_path)

  local image = Image.new(wsl_path)
  local height = image.height .. "px"
  local width = image.width .. "px"
  local ext = image.ext

  config.background[1].height = height
  config.background[1].width = width
  config.background[1].source.File = windows_path
  M.__current_source_file = windows_path
  if history_current > 1 then
    for i = 1, history_current - 1 do
      table.remove(history_list, i)
    end
  end
  M.__history_table.current = 1
  M.add_history(windows_path)
end

-- set wezterm config source file
-- @param   path windows path
-- @return  void
function M.set_source_file(windows_path)
  local config = M.__content_table
  local history_list = M.__history_table.list or {}
  local history_current = M.__history_table.current or 1
  local wsl_path = Path.convert_wsl_path(windows_path)

  local image = Image.new(wsl_path)
  local height = image.height .. "px"
  local width = image.width .. "px"
  local ext = image.ext

  config.background[1].height = height
  config.background[1].width = width
  config.background[1].source.File = windows_path
  M.__current_source_file = windows_path
  if history_current > 1 then
    for i = 1, history_current - 1 do
      P(" remove table list : " .. i)
      table.remove(history_list, i)
    end
  end
  M.__history_table.current = 1
  M.add_history(windows_path)
end

-- get wezterm config source file
-- @param   void
-- @return  path windows path
function M.get_source_file()
  if not M.__content_table then
    return nil
  end
  local config = M.__content_table
  return config.background[1].source.File
end

function M.release()
  if not M.__content_table then
    M.__content_table = nil
  end
  if not M.__history_table then
    M.__history_table = nil
  end
end

-- get wezterm config source file
-- @param   void
-- @return  path windows path
function M.load()
  if M.__content_table then
    return M.__content_table
  end
  M.__content_table = dofile(M.__config_path)
  M.__history_table = dofile(M.__history_file)
  local config = M.__content_table
  local history = M.__history_table
  M.__current_source_file = config.background[1].source.File
end

function M.dump()
  -- Logger.Info(M.__content_table)
end

-- saving wezterm config background.lua";
-- @param   void
-- @return  void
function M.save()
  local config = M.__content_table
  local serialized_data

  serialized_data = M.__dump_table(config, "")

  local content_root = "config"

  local update_file, err = assert(io.open(M.__config_path, "w"))
  local update_timestamp = "-- " .. M.Now()

  if not update_file then
    update_file:close()
  else
    update_file:write(update_timestamp .. "\n")
    update_file:write("local config={}\n")
    update_file:write(content_root .. "=" .. serialized_data)
    update_file:write("\n")
    update_file:write("return config\n")
    update_file:close()
  end

  M.__content_table = nil
  M.__history_table = nil
end

function M.flush()
  local config = M.__content_table
  local history = M.__history_table
  local serialized_content = M.__dump_table(config, "")
  local serialized_history = M.__dump_table(history, "")

  -- update config file
  local content_root = "config"

  local update_file_path = M.__config_path
  local update_file, err = assert(io.open(update_file_path, "w"))
  local update_timestamp = "-- " .. M.Now()

  if not update_file then
    update_file:close()
  else
    update_file:write(update_timestamp .. "\n")
    update_file:write("local config={}\n")
    update_file:write(content_root .. "=" .. serialized_content)
    update_file:write("\n")
    update_file:write("return config\n")
    update_file:close()
  end
  M.Flush_history(M.__history_file)
end

M.__dump_table = function(t, indent)
  if type(t) ~= "table" then
    return tostring(t)
  end

  local str = "{\n"
  for k, v in pairs(t) do
    if type(v) == "table" then
      if type(k) == "number" then
        str = string.format("%s%s%s%s,\n", str, indent, "\t", M.__dump_table(v, indent .. "\t"))
      else
        str = string.format("%s%s%s%s=%s,\n", str, indent, "\t", tostring(k), M.__dump_table(v, indent .. "\t"))
      end
    elseif type(v) == "string" then
      if type(k) == "number" then
        str = string.format("%s%s%s%q,\n", str, indent, "\t", v)
      else
        str = string.format("%s%s%s%s=%q,\n", str, indent, "\t", tostring(k), M.__dump_table(v, indent .. "\t"))
      end
    elseif type(k) == "number" then
      str = string.format("%s%s%s%s,\n", str, indent, "\t", M.__dump_table(v, indent .. "\t"))
    else
      str = string.format("%s%s%s%s=%s,\n", str, indent, "\t", tostring(k), tostring(v))
    end
  end

  str = str .. indent .. "}"
  return str
end

function M.Now()
  datetime = os.date("%m")
    .. "/"
    .. os.date("%d")
    .. " "
    .. os.date("%H")
    .. ":"
    .. os.date("%M")
    .. ":"
    .. os.date("%I")
  return datetime
end

return M

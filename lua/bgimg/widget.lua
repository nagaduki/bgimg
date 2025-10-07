-- local string = require("bgimg.widget.string")
--[[
M = {}

function M.string = function()
  return require("bgimg.widget.string")
end
]]

-- main modules
local widget = {
  function_list = {},
  variable_list = {},
  function_flag = false,
}

-- sub modules
widget.string = {}
widget.lines = {}

function str_sub(str, i, j)
  local length = vim.str_utfindex(str)
  if i < 0 then
    i = i + length + 1
  end
  if j and j < 0 then
    j = j + length + 1
  end
  local u = (i > 0) and i or 1
  local v = (j and j <= length) and j or length
  if u > v then
    -- return ""
    return nil
  end
  local s = vim.str_byteindex(str, u - 1)
  local e = vim.str_byteindex(str, v)
  return str:sub(s + 1, e)
end

function char_byte_count(s)
  -- local c = string.byte(s, i or 1)
  local c = string.byte(s, 1)

  -- Get byte count of unicode character (RFC 3629)
  if c > 0 and c <= 127 then
    return 1
  elseif c >= 194 and c <= 223 then
    return 2
  elseif c >= 224 and c <= 239 then
    -- return 3
    return 2
  elseif c >= 240 and c <= 244 then
    -- return 4
    return 2
  end
end

function widget.string.width(str)
  local i = 1
  local width = 0
  while str_sub(str, i, i) do
    width = width + char_byte_count(str_sub(str, i, i))
    i = i + 1
  end
  -- print("width: " .. width)
  return width
end

function widget.lines.wrap_count(lines_table, max_column)
  local wrap_count = 0
  -- local max_2bite = math.floor(max_column / 2)
  local max_column = math.floor(max_column)
  -- math.floor(vim.api.nvim_get_option("columns") * 4 / 5)

  for i = 1, #lines_table do
    if widget.string.width(lines_table[i]) > max_column then
      wrap_count = wrap_count + 1
    end
  end
  return wrap_count
end

return widget

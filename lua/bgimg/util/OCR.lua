-- local Advice = require("bgimg.util.Advice")
-- Todo. Singleton -> pathをセットしたらinstance で返すようにする.

local M = {}

M = {
  -- image_file = "~/Projects/resource/img.png",
  image_path = nil,
  -- text_file = "TEST.txt",
  text_path = nil,
  ocr_shell = "~/bin/ocr-check.sh",
}

function M.set_image_path(path)
  M.image_path = path

  -- automatically getnerate text_path and set to M.text.path.
  local ext = path:gsub("^%.(.*)", "%1"):match(".*%.(.*)")
  local text_path = string.gsub(path, ext, "")
  M.text_path = text_path .. "txt"
end

function M.get_image_path()
  return M.image_path
end

function M.set_text_path(path)
  M.text_path = path
end

function M.get_text_path()
  return M.text_path
end

function M.convert_to_string()
  -- local text_file = M.text_file
  -- local ocr_cmd = M.ocr_shell .. " " .. M.image_file .. " > " .. text_file
  local ocr_cmd = M.ocr_shell .. " " .. M.image_file
  local cmd_handle, err = assert(io.popen(ocr_cmd))
  local cmd_result = cmd_handle:read("*a")
  cmd_handle:close()
  return cmd_result
end

function M.convert_to_file(path)
  local redirect_file = path or M.text_path
  -- local ocr_cmd = ocr_shell .. " " .. M.image_file .. " > " .. path
  local ocr_cmd = M.ocr_shell .. " " .. M.image_path .. " | tee " .. redirect_file
  local cmd_handle, err = assert(io.popen(ocr_cmd))
  local cmd_result = cmd_handle:read("*a")
  cmd_handle:close()
  return cmd_result
end

--[[
function M.convert_to_table()
  ---
end
]]

return M

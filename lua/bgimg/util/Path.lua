-- local Logger = require("bgimg.util.Logger")
local Logger = require("bgimg.util.Logger")

local M = {}

M = {}

function M.exit(path)
  local file = io.open(path, "rb")
  if file then
    file:close()
    return true
  end
  return false
end

function M.copy(path1, path2)
  local input_file, input_err = assert(io.open(path1, "r"))
  local output_file, output_err = assert(io.open(path2, "w"))
  output_file:write(input_file:read("*all"))
  input_file:close()
  output_file:close()
end

function M.convert_windows_path(wsl_path)
  local windows_path = wsl_path:gsub("/", "\\\\"):gsub("\\\\mnt", "C:"):gsub("\\c\\", "")
  return windows_path
end

function M.convert_wsl_path(windows_path)
  local wsl_path = windows_path:gsub("C:\\", "/mnt/c/"):gsub("\\", "/"):gsub("//", "/")
  return wsl_path
end

function M.change_ext(path, new_ext)
  -- automatically getnerate text_path and set to M.text.path.
  local ext = path:gsub("^%.(.*)", "%1"):match(".*%.(.*)")
  local dot_path = string.gsub(path, ext, "")
  local new_path = dot_path .. new_ext
  return new_path
end

-- lua cant read dir.
get_choices = function(windows_dir)
  --[[
  local plenary_dir = os.getenv("PLENARY_DIR") or "/tmp/plenary.nvim"
  local is_not_a_directory = vim.fn.isdirectory(plenary_dir) == 0
  if is_not_a_directory then
    vim.fn.system({ "git", "clone", "https://github.com/nvim-lua/plenary.nvim", plenary_dir })
  end
	--]]

  local target_dir, input_err = assert(io.open(windows_dir, "r"))
  if target_dir then
    print(target_dir:read("*a"))
  else
    print("failed to read dir.")
  end
  target_dir:close()
end

return M

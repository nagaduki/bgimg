-- local Logger = require("bgimg.util.Logger")
local Logger = require("bgimg.util.Logger")

local M = {}

M = {
  --[[
  Exists = function(path)
    local file = io.open(path, "rb")

    if file then
      file:close()
      return true
    end

    return false
  end,

  Copy = function(path1, path2)
    local logger = Logger.new("PATH_TEST")
    logger:info("copy function: " .. path1 .. " : " .. path2)
    -- file, err = assert ( io.open ( log_file, "a+" ) )
    local input_file, input_err = assert(io.open(path1, "r"))
    local output_file, output_err = assert(io.open(path2, "w"))
    output_file:write(input_file:read("*all"))
    input_file:close()
    output_file:close()
  end,

  Convert_windows_path = function(unix_path)
    local windows_path = unix_path:gsub("/", "\\\\"):gsub("\\\\mnt", "C:"):gsub("\\c\\", "")

    return windows_path
  end,

  Convert_wsl_path = function(windows_path)
    local wsl_path = windows_path:gsub("C:\\", "/mnt/c/"):gsub("\\", "/"):gsub("//", "/")
    -- Logger .Info( "windows path: " .. windows_path )
    -- Logger .Info( "    wsl path: " .. wsl_path )
    return wsl_path
  end,

  Get_choices = function(windows_path)
    Logger.Info(windows_path)
    local input_file, input_err = assert(io.open(windows_path, "r"))
    if input_file then
      print(input_file:read("*a"))
    else
      print("failed to read")
    end
    input_file:close()
  end,
	]]
}

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

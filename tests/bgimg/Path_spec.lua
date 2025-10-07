-- local ClassC = require("bgimg.sandbox.ClassC")
-- local P = require("bgimg.util.P")
local Path = require("bgimg.util.Path")
local colors = require("ansicolors")
local logging = require("logging")

require("logging.file")
-- init_spec.lua
local logger = logging.file({
  filename = "log/test_ClassC_%s.log",
  datePattern = "%Y-%m-%d",
})

logger:info("Path test")

describe("copy test", function()
  describe("copy", function()
    it("'A.txt' copy 'B.txt'", function()
      path1 = "tests/bgimg/A.txt"
      path2 = "tests/bgimg/B.txt"
      --
      Path.copy(path1, path2)
      --
      local path2_fd, path2_err = assert(io.open(path2, "r"))
      -- file remove
      os.remove(path2)
    end)
  end)
  describe("convert_windows_path", function()
    it("/mnt/c/share/.. convert windows path.", function()
      local wsl_path = "/mnt/c/share/Documents/img.png"
      local windows_path = string.format("%q", "C:\\share\\Documents\\img.png")
      local converted_path = '"' .. Path.convert_windows_path(wsl_path) .. '"'
      assert.are.same(converted_path, windows_path)
      assert.are.same(windows_path, converted_path)
    end)
  end)
  describe("convert_wsl_path", function()
    it("c:drive path convert wsl path", function()
      local wsl_path = '"/mnt/c/share/Documents/img.png"'
      local windows_path = string.format("%q", "C:\\share\\Documents\\img.png")
      local converted_path = Path.convert_wsl_path(windows_path)
      assert.are.same(wsl_path, converted_path)
    end)
  end)

  describe("change ext", function()
    it("c:drive path convert wsl path", function()
      local old_path = "/mnt/c/share/Documents/img.png"
      local new_path = "/mnt/c/share/Documents/img.txt"

      local changed_path = Path.change_ext(old_path, "txt")
      assert.are.same(new_path, changed_path)
    end)
  end)
end)

local Image = require("bgimg.util.Image")
local ImageBuilder = require("bgimg.util.ImageBuilder")
local P = require("bgimg.util.P")
local colors = require("ansicolors")
local logging = require("logging")
require("logging.file")
-- init_spec.lua

--local Advice = require("bgimg.util.Advice")
--Advice.function_list={"new"}

local logger = logging.file({
  filename = "log/test_Image_%s.log",
  datePattern = "%Y-%m-%d",
})

logger:info(colors("Image %{red}busted%{reset} test."))

describe("image size test", function()
  describe("get_height", function()
    it("'img1.png' height '936'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img1.png"
      local img = Image.new(path)
      local height = img:get_height()

      -- logger:info("content: " .. c:to_string())
      assert.is_equal(height, 936)
    end)
    it("'img1.png' width '750'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img1.png"
      local img = ImageBuilder.of_default():with_path(path):build()
      local width = img:get_width()

      assert.is_equal(width, 750)
    end)
    it("'img1.png' type 'png'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img1.png"
      local img = ImageBuilder.of_default():with_path(path):build()
      local ext = img:get_ext()

      assert.is_equal(ext, "png")
    end)
    it("'img2.png' height '628'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img2.png"
      local img = Image.new(path)
      local height = img:get_height()

      -- logger:info("content: " .. c:to_string())
      assert.is_equal(height, 628)
    end)
    it("'img2.png' width '747'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img2.png"
      local img = ImageBuilder.of_default():with_path(path):build()
      local width = img:get_width()

      assert.is_equal(width, 747)
    end)
    it("'img2.png' type 'png'", function()
      local path = "/home/aug/Projects/git/bgimg/tests/bgimg/img2.png"
      local img = ImageBuilder.of_default():with_path(path):build()
      local ext = img:get_ext()

      assert.is_equal(ext, "png")
    end)
  end)
end)

-- P(colors("%{red}ClassC%{reset} test."))
-- P("package.path: " .. package.path)

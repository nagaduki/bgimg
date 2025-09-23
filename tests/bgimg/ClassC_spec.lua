local ClassC = require("bgimg.sandbox.ClassC")
local P = require("bgimg.util.P")
local colors = require("ansicolors")
local logging = require("logging")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
  filename = "log/test_ClassC_%s.log",
  datePattern = "%Y-%m-%d",
})

logger:info("ClassC test")

describe("to_string test", function()
  describe("to_string", function()
    it("'abc' to_string 'abc'", function()
      str1 = "abc"
      local c = ClassC.new(str1)
      str2 = c:to_string()

      logger:info("content: " .. c:to_string())
      -- logger:info("strx: " .. strx.content)
      assert.is_equal(str1, str2)
    end)
  end)
end)

-- P(colors("%{red}ClassC%{reset} test."))
-- P("package.path: " .. package.path)

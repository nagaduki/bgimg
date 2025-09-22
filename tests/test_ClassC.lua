local ClassC = require("ClassC")
local P = require("P")
local colors = require("ansicolors")
local logging = require("logging")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
	filename = "log/test_Stringx_%s.log",
	datePattern = "%Y-%m-%d",
})

logger:info("Stringx test")

describe("Stringx test", function()
	describe("trim", function()
		it("' abc ' length is 3", function()
			local c = ClassC.new(" abc ")
			logger:info("strx: " .. c:to_string())
			-- logger:info("strx: " .. strx.content)
			assert.is_truthy(0)
		end)

		it("'1' equal '0'", function()
			assert.is_equal(1, 0)
		end)
	end)
end)

P(colors("%{red}Stringx%{reset} test."))
P("package.path: " .. package.path)

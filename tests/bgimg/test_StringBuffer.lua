local StringBuffer = require("StringBuffer")
local StringBufferBuilder = require("StringBufferBuilder")
local P = require("P")
local colors = require("ansicolors")
local busted = require("busted")
local logging = require("logging")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
	filename = "log/test_StringBuffer_%s.log",
	datePattern = "%Y-%m-%d",
})

function Now()
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

describe("StringBuffer test", function()
	describe("trim", function()
		it("' abc ' length is 3", function()
			-- Arrange
			local str = " abc "
			local sbuf = StringBuffer.new(str)
			logger:info(Now() .. " StringBuffer.new " .. "'" .. sbuf:to_string() .. "'")

			-- Act
			local trimed = sbuf:trim()
			logger:info(Now() .. " StringBuffer:trim " .. "'" .. sbuf:trim() .. "'")

			-- Assert
			assert.is.not_equal(str:len(), trimed:len())
		end)

		it("' abc '.trim() equal 'abc'", function()
			-- Arrange
			local str = " abc "
			local sbb1 = StringBufferBuilder.of_default()
			-- local sbuf = sbb1:hello()
			local sbuf = sbb1:with_content(str):build()

			-- Act
			local trimed = sbuf:trim()

			-- Assert
			assert.is_same(trimed, "abc")
		end)

		it("'abc '.trim() equal 'abc'", function()
			-- Arrange
			local str = "abc "
			local sbuf = StringBufferBuilder.of_default():with_content(str):build()

			-- Act
			local trimed = sbuf:trim()

			-- Assert
			assert.is_same(trimed, "abc")
		end)

		it("' abc'.trim() equal 'abc'", function()
			-- Arrange
			local str = " abc"
			local sbuf = StringBufferBuilder.of_default():with_content(str):build()

			-- Act
			local trimed = sbuf:trim()

			-- Assert
			assert.is_same(trimed, "abc")
		end)

		it("'abc'.trim() equal 'abc'", function()
			-- Arrange
			local str = "abc"
			local sbuf = StringBufferBuilder.of_default():with_content(str):build()

			-- Act
			local trimed = sbuf:trim()

			-- Assert
			assert.is_same(trimed, "abc")
		end)
	end)

	describe("spilt", function()
		it("'A,B,C,D,E,F'.spilt() equal 'A','B','C','D','E','F'", function()
			-- Arrange
			local str = "A,B,C,D,E,F"
			local sbuf = StringBufferBuilder.of_default():with_content(str):build()

			-- Act
			local A, B, C, D, E, F = sbuf:split(",")

			-- Assert
			assert.is_same(A, "A")
			assert.is_same(B, "B")
			assert.is_same(C, "C")
			assert.is_same(D, "D")
			assert.is_same(E, "E")
			assert.is_same(F, "F")
		end)
	end)

	describe("spilt", function()
		it("'A, B, C, D, E, F'.spilt() equal 'A',' B',' C',' D',' E',' F'", function()
			-- Arrange
			local str = "A, B, C, D, E, F"
			local sbuf = StringBufferBuilder.of_default():with_content(str):build()

			-- Act
			local A, B, C, D, E, F = sbuf:split(",")

			-- Assert
			assert.is_same(A, "A")
			assert.is_same(B, " B")
			assert.is_same(C, " C")
			assert.is_same(D, " D")
			assert.is_same(E, " E")
			assert.is_same(F, " F")
		end)
	end)
end)

P(colors("Stringx %{red}busted%{reset} test."))

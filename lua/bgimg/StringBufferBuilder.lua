local logging = require("logging")
local Object = require("Object")
local StringBuffer = require("StringBuffer")
local ansicolors = require("ansicolors")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
	filename = "log/test_StringBufferBuilder_%s.log",
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

-- Class: StringBufferBuilder
local M = {}

M = {
	new = function()
		local obj = {
			content = "",
			trimming = false,
		}

		return obj
	end,

	of_default = function()
		-- logger:info(Now() .. " StringBufferBuilder.of_default ")
		local obj = Object:prototype(M)
		-- local obj = {}
		obj.content = ""
		obj.trimming = false

		return obj
	end,
}

function M:hello()
	print("hello StringBufferBuilder.")
end

function M:build()
	-- self.stringbuffer = StringBuffer.new(str)

	local stringbuffer = StringBuffer.new(self.content)
	stringbuffer.trimming = self.trimming

	return stringbuffer
end

function M:with_content(str)
	logger:info(Now() .. " StringBufferBuilder.with_content " .. "'" .. str .. "'")
	self.content = str
	return self
end

function M:toggle_trimming(flag)
	-- self.stringbuffer = StringBuffer.new(str)
	self.trimming = flag
	return self
end

-- Class: StringBufferBuilder
return M

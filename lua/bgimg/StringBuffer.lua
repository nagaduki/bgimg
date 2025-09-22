local logging = require("logging")
local Object = require("Object")
local ansicolors = require("ansicolors")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
	filename = "log/test_StringBuffer_%s.log",
	datePattern = "%Y-%m-%d",
})

local M = {}
--ClassC = {
M = {

	new = function(str)
		local obj = Object:prototype(M)
		obj.content = str
		obj.trimming = false

		return obj
	end,
}

function M:to_string()
	return self.content
end

function M:trim()
	return self.content:gsub("^%s*(.-)%s*$", "%1")
end

function M:split(delim)
	-- Eliminate bad cases...
	local str = self.content
	if string.find(str, delim) == nil then
		return { str }
	end

	local result = {}
	local pat = "(.-)" .. delim .. "()"
	local lastPos
	for part, pos in string.gmatch(str, pat) do
		table.insert(result, part)
		lastPos = pos
	end
	table.insert(result, string.sub(str, lastPos))
	return table.unpack(result)
	-- return table.unpack(split(string.gsub(result, "^%s*(.-)%s*$", "%1"), " "))
end

return M

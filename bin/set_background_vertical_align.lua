local Logger = require("bgimg.util.Logger")
local Path = require("bgimg.util.Path")
local P = require("bgimg.util.P") -- custom print function
local BackGroundManager = require("bgimg.util.BackGroundManager")
local Image = require("bgimg.util.Image")

Logger.LEVEL = Logger.DEBUG

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

local function sleep(second)
	local start = os.time()
	while os.time() - start < second do
	end
end

local ALIGN = arg[1]
-- P("wezterm background horizontal align: " .. ALIGN)

BackGroundManager.load()
BackGroundManager.set_vertical_align(ALIGN)
BackGroundManager.dark()
BackGroundManager.flush()

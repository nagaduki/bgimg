local Logger = require("Logger")
local Path = require("Path")
local P = require("P") -- custom print function
local BackGroundManager = require("BackGroundManager")
local Image = require("Image")

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

local mag_rate = arg[1]
P("wezterm background mag rate: " .. tostring(mag_rate))

BackGroundManager.Load()
--Logger.Info(BackGroundManager.Get_content())
BackGroundManager.Zoom(mag_rate)
BackGroundManager.Dark()
BackGroundManager.Flush()

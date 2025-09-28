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

local image_path = arg[1]

P("wezterm background image: " .. image_path)

local windows_path = Path.convert_windows_path(image_path)

BackGroundManager.Load()
BackGroundManager.set_source_file(windows_path)
BackGroundManager.dark()
BackGroundManager.set_vertical_align("Middle")
BackGroundManager.set_horizontal_align("Center")
BackGroundManager.zoom(1.5)
BackGroundManager.flush()

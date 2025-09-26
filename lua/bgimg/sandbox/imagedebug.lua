local Logger = require("Logger")
local P = require("P") -- custom print function
local Image = require("Image") -- custom print function

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

P("----------------------")
P(" Image lib .png TEST. ")
P("----------------------")

local img_path = "./img.png"

P("---[img.png]---")
local image = Image.new(img_path)
P("height: " .. image.height)
P(" width: " .. image.width)
-- P( "  type: " .. image.type )

local img_path2 = "/mnt/c/share/Documents/01-C-table04.png"

P("---[/mnt/c/share/Documents/01-C-table04.png]---")

local image2 = Image.new(img_path2)
P("height: " .. image2.height)
P(" width: " .. image2.width)
--P("  type: " .. image2.type)
--
local img_path3 = string.format("%s", img_path2)
local image3 = Image.new(img_path3)
P("height: " .. image3.height)
P(" width: " .. image3.width)
--P("  type: " .. image2.type)
image3:hello()


--

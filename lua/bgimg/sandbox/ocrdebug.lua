local OCR = require("bgimg.util.OCR")
-- local Advice = require("bgimg.util.Advice")
local text = ""

OCR.set_image_path("~/Projects/resource/img.png")
-- OCR.set_text_file("~/Projects/resource/img.txt")
text = OCR.get_text_path() or ""
print("auto text: " .. text)
local text_contents = OCR.convert_to_file()

OCR.set_text_path("~/Projects/resource/NEW.txt")
text = OCR.get_text_path() or ""
print("NEW text: " .. text)
local text_contents = OCR.convert_to_file()

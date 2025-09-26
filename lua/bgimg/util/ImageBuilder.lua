-- local t = require("template")
-- template has member field.
local Object = require("bgimg.core.Object")
local Image = require("bgimg.util.Image")

-- for TEST
local logging = require("logging")
local ansicolors = require("ansicolors")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
  filename = "log/test_ImageBuilder_%s.log",
  datePattern = "%Y-%m-%d",
})

local function Now()
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



-- Class: TemplateBuilder
local M = {}

M = {
  new = function()
    -- new = function(member)
    local obj = {
      img_path = "",
    }
    return obj
  end,

  of_default = function()
    local obj = Object:prototype(M)
    obj.img_path = ""
    return obj
  end,
}

function M:hello()
  -- print("hello "..self.member..".")
  print("hello ImageBuilder.")
end

function M:build()
  local image = Image.new(self.img_path)
  return image
end

function M:with_path(str)
  logger:info(Now() .. " builder.with_path " .. "'" .. str .. "'")
  self.img_path = str
  return self
end

-- Class: BuilderTemplate
return M

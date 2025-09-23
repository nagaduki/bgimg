-- local t = require("template")
-- template has member field.
local Object = require("Object")

local logging = require("logging")
local ansicolors = require("ansicolors")
require("logging.file")
-- init_spec.lua
local logger = logging.file({
  filename = "log/test_TemplateBuilder_%s.log",
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

-- Class: TemplateBuilder
local M = {}

M = {
  new = function()
  -- new = function(member)
    local obj = {
	--[[
	member = ""
	]]
    }
    return obj
  end,

  of_default = function()
    local obj = Object:prototype(M)
    return obj
  end,
}

function M:hello()
  -- print("hello "..self.member..".")
  print("hello "..self.member..".")
end

function M:build()
  local template = Template.new(self.member)
  return template
end

function M:with_member(str)
  logger:info(Now() .. " builder.with_member " .. "'" .. str .. "'")
  self.member = member
  return self
end

-- Class: BuilderTemplate
return M

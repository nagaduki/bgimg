local Advice = require("bgimg.util.Advice")
Advice.function_list = {"new"} 
Advice.variable_list = {}

local ClassC = require("bgimg.sandbox.ClassC")
local ClassD = require("bgimg.sandbox.ClassD")

local c = ClassC.new("TEST")
c:to_string()

local d = ClassD.new()
d.name = "lua"
d.id   = "123"


print("name: "..d:get_name())
print("id  : "..d:get_id())

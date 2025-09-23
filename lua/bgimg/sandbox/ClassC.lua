local Object = require("bgimg/core/Object")
--
local M = {}
--ClassC = {
M = {
  new = function(str)
    local obj = Object:prototype(M)
    obj.content = str

    return obj
  end,

  to_string = function(self)
    return self.content
  end,
}

return M

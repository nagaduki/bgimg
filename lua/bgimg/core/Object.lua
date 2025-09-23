-- History:
-- version 2025/09/07 for Collection
-- version 2025/09/20 for bgimg
-- ToDo:
-- - finilazer
-- - PersitsObject(save, load, dump, eval)
-- - setmetatble __call -> getter setter auto generation.

Object = {
  new = function(...)
    local obj = {}
    for k, v in pairs({ ... }) do
      obj[k] = v
    end
    setmetatable(obj, { __index = Object })

    local meta = {
      __index = Object,
      __GC = Object:finalize(),
    }
    obj = setmetatable(obj, meta)

    return obj
  end,

  hello = function(self)
    print("Object: hello world")
  end,

  -- finalize = function ( self ) print ( "Object is finalized." ) end;
  finalize = function(self) end,

  prototype = function(super, class, ...)
    local self = (super and super.new(...) or {})
    setmetatable(class, { __index = super })
    setmetatable(self, { __index = class })
    return self
  end,
}

return Object

-- local Logger = require ( 'Logger' )
-- version 2025/09/07 for Collection

Object = {
	new = function(...)
		-- Logger.Debug ( ... )
		local obj = {}
		-- buggy
		for k, v in pairs({ ... }) do
			obj[k] = v
		end
		-- buggy
		setmetatable(obj, { __index = Object })

		local meta = {
			__index = Object,
			-- __GC = function ()
			-- 	if not file then obj.file:close () end
			-- end
			__GC = Object:finalize(),
		}
		obj = setmetatable(obj, meta)

		--[[
		if obj.define then
			print ( "Object: define method." )
			obj.define (...) 
		end
]]

		return obj
	end,

	hello = function(self)
		print("Object: hello world")
	end,

	--finalize = function ( self ) print ( "Object is finalized." ) end;
	finalize = function(self) end,

	--[[
	prototype = function ( super, class, ... )
		-- print ( "Object: prototype method." )
		Logger.Debug ( {super, class, ... } )
		local self = ( super and super.new ( ... ) or {} )
		setmetatable ( self, { __index = class } )
		setmetatable ( class, { __index = super } )
		return self
	end;
]]

	prototype = function(super, class, ...)
		-- print ( "Object: prototype method." )
		-- Logger.Debug ( {super, class, ... } )
		local self = (super and super.new(...) or {})
		setmetatable(class, { __index = super })
		setmetatable(self, { __index = class })
		return self
	end,
}

return Object

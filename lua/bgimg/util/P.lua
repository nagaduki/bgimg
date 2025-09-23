P = {}

P.custom_printer = function ( self, target )
	--
	print ( target )
end

function createPrint ()
	local p = {}
	setmetatable ( p, P )
	return p
end

P.__index = function ( self, key )
	return function ( target )
		return P[key](self, target)
	end
end

Now = function ()
	datetime = os.date("%m").."/"..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%I")
	return datetime
end;

local p1 = createPrint ()
local p2 = p1.custom_printer

-- p("hello")
-- p("ABC" .. "XYZ" )

return p2

local M = {}

M = {
	new = function ()
		local obj = {}
		local ext = "png"
		---
		obj.name = ""
		obj.id = ""
		obj.get_name = function (self)
			return self.name
		end
		obj.get_id = get_id
		return obj
	end,
}

function get_id(self)
	return self.id
end

return M
	
	



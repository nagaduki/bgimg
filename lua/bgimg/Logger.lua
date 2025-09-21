Logger = {
	DEBUG = 1,
	INFO = 2,
	WARN = 4,
	ERROR = 8,
	RELEASE = 16,
	LEVEL = 1,
	WAIT = 1,

	FUNCTIONNAMELENGTH = 10,

	Now = function()
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
	end,

	new = function(name)
		local obj = Object:prototype(Logger)
		local file, err
		local now = Logger.Now()
		-- local datetime = os.date("%m")..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%I")
		local file_path = debug.getinfo(2, "S").source:sub(2):match("(.*[/\\])") or "./"
		local log_file = (file_path .. name .. ".log")
		obj.name = name
		obj.path = file_path

		--[[
		print ( "logger new: " )
		print ( " name: " .. obj.name  )
		print ( " path: " .. file_path )
		]]
		file, err = assert(io.open(log_file, "a+"))

		if not file then
			print(log_file .. " : " .. err)
		else
			obj.file = file
			file:write(now .. " log start.\n")
		end

		--[[
		--close transaction
		assert ( file:close () )
		]]

		return obj
	end,

	-- instance method
	-- @param  self
	-- @return void
	trace = function(self)
		-- print ( "instance method: trace ()" )
		local file = self.file
		local now = Logger.Now()
		-- local datetime = os.date("%m").."/"..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%I")

		local i = 1
		local str = ""

		while debug.getinfo(i).currentline ~= -1 do
			-- print ( " [line: ]" .. debug.getinfo ( i ).currentline );
			str = str .. " \t" .. debug.getinfo(i).source:match("[^/]*$"):gsub("%.%w+$", "") .. ":"
			str = str .. (debug.getinfo(i).name or "main") .. ":"
			str = str .. debug.getinfo(i).currentline .. "\n"
			-- str = str .. tostring ( debug.getinfo ( i ).func ) .. "\n";
			i = i + 1
		end

		if not file then
			print(obj.name .. ".log" .. " : ERORR")
		else
			file:write("[trace]" .. now .. "\n" .. str)
		end
	end,

	-- Class method
	-- @return void
	Trace = function()
		local i = 1
		local str = ""
		while debug.getinfo(i).currentline ~= -1 do
			-- print ( " [line: ]" .. debug.getinfo ( i ).currentline );
			str = str .. " \t" .. debug.getinfo(i).source:match("[^/]*$"):gsub("%.%w+$", "") .. ":"
			str = str .. (debug.getinfo(i).name or "main") .. ":"
			str = str .. debug.getinfo(i).currentline .. "\n"
			-- str = str .. tostring ( debug.getinfo ( i ).func ) .. "\n";
			i = i + 1
		end
		print("[Trace]\n" .. str)
	end,

	-- Class method
	-- @param event Call, Line,
	-- @param line  if event is Line, input line which described line number.
	Hook = function(event, line)
		local max = Logger.FUNCTIONNAMELENGTH
		local len
		local info = debug.getinfo(2, "Sln")

		local name
		local source = info.source
		if info then
			name = info.name or "main"
		end

		len = name:len()
		if max > len then
			len = max - len
			for i = 1, len do
				name = name .. " "
			end
		end
		fixed_name = name:sub(1, max)

		trimed_source = source:gsub("%.%w+$", "")
		len = trimed_source:len()
		if max > len then
			len = max - len
			for i = 1, len do
				trimed_source = " " .. trimed_source
			end
		end
		fixed_source = trimed_source:sub(1, max)

		local line = line or "N/A"
		print(string.format("[ HOOK] E: %6s, F: %." .. max .. "s, S: %s, %s", event, fixed_name, fixed_source, line))
	end,

	-- Class method
	-- @param  data   table
	-- @return string seriarized string.
	Dump = function(data)
		-- Logger.Trace ();
		if type(data) ~= "table" then
			return tostring(data)
		end

		-- recursive function
		-- @param t table
		-- @param indent seriarized string
		-- @return  string seriarized string.
		dump_table = function(t, indent)
			local str = "{\n"
			for k, v in pairs(t) do
				if type(v) == "table" then
					-- str = string.format("%s%s%s%s=%s,\n",str,indent,"\t",tostring(k),dump_table(v,indent.."\t"));
					-- str = string.format("%s%s%s%s=%s,\n",str,indent,"\t",tostring(k),dump_table(v,indent.."\t"));
					if type(k) == "number" then
						str = string.format("%s%s%s%s,\n", str, indent, "\t", dump_table(v, indent .. "\t"))
					else
						str = string.format(
							"%s%s%s%s=%s,\n",
							str,
							indent,
							"\t",
							tostring(k),
							dump_table(v, indent .. "\t")
						)
					end
					-- str = string.format("%s%s%s%s,\n",str,indent,"\t",dump_table(v,indent.."\t"));
				elseif type(v) == "string" then
					str = string.format("%s%s%s%s=%q,\n", str, indent, "\t", tostring(k), v)
				else
					-- str = string.format("%s%s%s%s=\"%s\",\n",str,indent,"\t",tostring(k),tostring(v));
					str = string.format("%s%s%s%s=%s,\n", str, indent, "\t", tostring(k), tostring(v))
				end
			end

			--
			str = str .. indent .. "}"
			return str
		end

		return dump_table(data, "")
	end,

	-- Class method
	-- void
	Debug = function(value)
		local datetime = os.date("%m")
			.. os.date("%d")
			.. " "
			.. os.date("%H")
			.. ":"
			.. os.date("%M")
			.. ":"
			.. os.date("%I")
		if Logger.LEVEL == Logger.RELEASE then
			return
		end
		if Logger.LEVEL <= Logger.DEBUG then
			-- local debug_line = debug.getinfo(1).currentline
			Logger.Trace()
			local debug_text = ("[Debug][" .. datetime .. "]" .. Logger.Dump(value))
			print(debug_text)
		end
	end,

	-- Class method
	-- @return void
	-- @see Logger.Dump ()
	--[[
	Info = function ( value )
		-- os.execute ( "sleep 3" )
		-- vim.fn.system({"sleep", "5s"})
		local file = self.file
		local now  = Logger.Now ()

		if Logger.LEVEL == Logger.RELEASE then return end;


		if Logger.LEVEL <= Logger.INFO then 
			-- Logger.Trace ();
			local debug_text = ("[ info]["..now.."]"..Logger.Dump(value));
			print ( debug_text );

			if not file then 
				print ( self.name .. ".log" .. " : ERORR" ) 
			else
				file:write ( "[trace]\n"..now.."\n"..debug_text )
			end
		end

	end;
	]]

	-- Class method
	-- void
	Info = function(value)
		-- os.execute ( "sleep 3" )
		-- vim.fn.system({"sleep", "5s"})
		-- local datetime = os.date("%m")..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%I")
		local now = Logger.Now()
		local data

		if type(value) == "string" then
			data = value
		else
			data = Logger.Dump(value)
		end

		if Logger.LEVEL == Logger.RELEASE then
			return
		end
		if Logger.LEVEL <= Logger.INFO then
			-- Logger.Trace ();
			local debug_text = ("[ Info][" .. now .. "]" .. data .. "\n")
			print(debug_text)
		end
	end,

	-- Instance method
	-- void
	info = function(self, value)
		local file = self.file
		local now = Logger.Now()
		local data

		if type(value) == "string" then
			data = value
		else
			data = Logger.Dump(value)
		end

		if Logger.LEVEL == Logger.RELEASE then
			return
		end
		if Logger.LEVEL <= Logger.INFO then
			-- Logger.Trace ();
			if not file then
				print(self.name .. ".log" .. " : ERORR")
			else
				local debug_text = ("[ info][" .. now .. "]" .. data .. "\n")
				file:write(debug_text)
			end
		end
	end,

	-- Class method
	-- void
	Warn = function(value)
		datetime = os.date("%m")
			.. os.date("%d")
			.. " "
			.. os.date("%H")
			.. ":"
			.. os.date("%M")
			.. ":"
			.. os.date("%I")
		if Logger.LEVEL == Logger.RELEASE then
			return
		end
		if Logger.LEVEL <= Logger.WARN then
			-- Logger.Trace ();
			local debug_text = ("[ Warn][" .. datetime .. "]" .. Logger.Dump(value))
			print(debug_text)
		end
	end,

	-- Class method
	-- void Class
	Error = function(value)
		datetime = os.date("%m")
			.. os.date("%d")
			.. " "
			.. os.date("%H")
			.. ":"
			.. os.date("%M")
			.. ":"
			.. os.date("%I")
		if Logger.LEVEL == Logger.RELEASE then
			return
		end
		if Logger.LEVEL <= Logger.ERROR then
			-- Logger.Trace ();
			local debug_text = ("[Error][" .. datetime .. "]" .. Logger.Dump(value))
			print(debug_text)
		end
	end,
}

return Logger

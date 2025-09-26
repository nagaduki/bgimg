-- CAUTION you must use LUAJIT.
-- local colors = require("ansicolors")
-- version 2025/09/25

local Advice = {
  function_list = {},
  variable_list = {},
  function_flag = false,
}

function Advice.set_function_list(list)
  Advice.function_list = list
end

function Advice.set_variable_list(list)
  Advice.variable_list = list
end

function Advice.print_function_list()
  for i = 1, #Advice.function_list do
    print(Advice.function_list[i])
  end
end

function Advice.print_variable_list()
  for i = 1, #Advice.variable_list do
    print(Advice.variable_list[i])
  end
end

-- Class method
-- @param  data   table
-- @return string seriarized string.
function Advice.dump(data)
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
        if type(k) == "number" then
          str = string.format("%s%s%s%s,\n", str, indent, "\t", dump_table(v, indent .. "\t"))
        else
          str = string.format("%s%s%s%s=%s,\n", str, indent, "\t", tostring(k), dump_table(v, indent .. "\t"))
        end
      elseif type(v) == "string" then
        str = string.format("%s%s%s%s=%q,\n", str, indent, "\t", tostring(k), v)
      else
        str = string.format("%s%s%s%s=%s,\n", str, indent, "\t", tostring(k), tostring(v))
      end
    end

    str = str .. indent .. "}"
    return str
  end

  return dump_table(data, "")
end

function Advice.insert_before_function(p)
  local function_name = debug.getinfo(2).name
  local source_name = debug.getinfo(2).source

  if #Advice.function_list == 0 then
    print("function: " .. Advice.dump(function_name) .. " " .. source_name)
    print("[before]")
    local i = 1
    while true do
      local name, value = debug.getlocal(2, i)
      if not name then
        break
      end
      print(" ", i .. ":", name, Advice.dump(value))
      i = i + 1
    end
    Advice.function_flag = true
  else
    for i = 1, #Advice.function_list do
      if function_name == Advice.function_list[i] then
        print("function: " .. Advice.dump(function_name) .. " " .. source_name)
        print("[before]")
        local i = 1
        while true do
          local name, value = debug.getlocal(2, i)
          if not name then
            break
          end

          if #Advice.variable_list == 0 then
            print(" ", i .. ":", name, Advice.dump(value))
          else
            for i = 1, #Advice.variable_list do
              if name == Advice.variable_list[i] then
                print(" ", i .. ":", name, Advice.dump(value))
              end
            end
          end
          i = i + 1
        end
        Advice.function_flag = true
      end
    end
  end

  debug.sethook(Advice.insert_after_function, "r")
end

function Advice.insert_after_function(p)
  if Advice.function_flag then
    print("[afer]")

    local i = 1
    while true do
      local name, value = debug.getlocal(2, i)
      if not name then
        break
      end
      if #Advice.variable_list == 0 then
        print(" ", i .. ":", name, Advice.dump(value))
      else
        for i = 1, #Advice.variable_list do
          if name == Advice.variable_list[i] then
            print(" ", i .. ":", name, Advice.dump(value))
          end
        end
      end
      i = i + 1
    end
    print(" ")
  end
  Advice.function_flag = false
  debug.sethook(Advice.insert_before_function, "c")
end

debug.sethook(Advice.insert_before_function, "c")

return Advice

local M = {}

M = {}

function M.save(obj, file)
  --
end

function M.eval(str)
  local obj = {}
  return obj
end

function M.load(file)
  local obj = {}
  return obj
end

function M.create_lines(file)
  local lines = {}
  local fd, err = assert(io.open(file, "r"))
  cnt = 1
  for line in fd:lines("l") do
    table.insert(lines, line)
    cnt = cnt + 1
  end
  fd:close()
  return lines
end

function M.dump(data)
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

return M

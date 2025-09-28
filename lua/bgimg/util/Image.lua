local Logger = require("bgimg.util.Logger")
local P = require("bgimg.util.P") -- custom print function

-- Class Image
M = {
  new = function(path)
    local obj = {}
    local img_path = string.format("%s", path)
    local IHDR = {}

    -- Don't work because ESCAPE
    -- local ext = path: gsub( "^%.(.*)", "%1") :match('.*%.(.*)')
    local ext = img_path:gsub("^%.(.*)", "%1"):match(".*%.(.*)")

    img_file, err = assert(io.open(img_path, "rb"))

    local block = 8
    -- while true do
    for i = 0, 2 do
      local bytes = img_file:read(block)

      if not bytes then
        obj.type = ""
        break
      end

      local j = 1
      for b in bytes:gmatch(".") do
        IHDR[i * block + j] = string.format("%02X", b:byte())
        j = j + 1
      end
    end
    img_file:close()

    local IHDR1 = IHDR[17]
    local IHDR2 = IHDR[18]
    local IHDR3 = IHDR[19]
    local IHDR4 = IHDR[20]
    local IHDR5 = IHDR[21]
    local IHDR6 = IHDR[22]
    local IHDR7 = IHDR[23]
    local IHDR8 = IHDR[24]

    local height16 = string.format("%s%s%s%s", IHDR5, IHDR6, IHDR7, IHDR8)
    local width16 = string.format("%s%s%s%s", IHDR1, IHDR2, IHDR3, IHDR4)

    obj.height = tonumber(height16, 16)
    obj.width = tonumber(width16, 16)
    obj.ext = ext

    obj.get_height = function(self)
      return self.height
    end

    obj.get_width = function(self)
      return self.width
    end

    obj.get_ext = function(self)
      return self.ext
    end

    obj.get_path = function(self)
      return self.img_path
    end

    return obj
  end,
}

-- Class Image
return M

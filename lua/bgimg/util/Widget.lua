local api = vim.api

local M = {}
-- create_buffer_content file_path
-- popup_window file_path
M = {
  option = nil,
  buffer = nil,

  new = function()
    local obj = {}
    obj.option = nil
    obj.buffer = nil
    obj.window = nil

    return obj
  end,

  len = function(str)
    str_sub = function(str, i, j)
      local length = vim.str_utfindex(str)
      if i < 0 then
        i = i + length + 1
      end
      if j and j < 0 then
        j = j + length + 1
      end
      local u = (i > 0) and i or 1
      local v = (j and j <= length) and j or length
      if u > v then
        -- return ""
        return nil
      end
      local s = vim.str_byteindex(str, u - 1)
      local e = vim.str_byteindex(str, v)
      return str:sub(s + 1, e)
    end

    char_byte_count = function(s)
      -- local c = string.byte(s, i or 1)
      local c = string.byte(s, 1)

      -- Get byte count of unicode character (RFC 3629)
      if c > 0 and c <= 127 then
        return 1
      elseif c >= 194 and c <= 223 then
        return 2
      elseif c >= 224 and c <= 239 then
        -- return 3
        return 2
      elseif c >= 240 and c <= 244 then
        -- return 4
        return 2
      end
    end
  end,

  wrap_count = function(lines_table, max_column)
    local wrap_count = 0
    local max_2bite = math.floor(max_column / 2)
    -- math.floor(vim.api.nvim_get_option("columns") * 4 / 5)

    for i = 1, 3 do
      if lines_table[i]:len() > max_column then
        wrap_count = wrap_count + 1
      end
    end
    return wrap_count
  end,

  floating_window = function(text_path, opt)
    vim.cmd("highlight PopupMenuFloatBorder guifg=#006db3")
    vim.cmd("highlight PopupMenuFloatTitle guifg=#6ab7ff")
    vim.cmd("highlight PopupMenuText guifg=#abb2bf")
    -- vim.cmd("highlight NonText bold=true")
    vim.cmd("highlight PopupMenuTextSelected guifg=#abb2bf guibg=#383c44")

    local default_opt = {
      title = { { "Widget Default Title.", "InputFloatTitle" } },
      title_pos = "left",
      -- relative = "editor", -- Position relative to the editor
      relative = "cursor", -- Position relative to the editor
      -- width = 600,vim_get_option('columns'),
      width = vim.api.nvim_get_option("columns"),
      height = vim.api.nvim_get_option("lines"),
      -- height = 100,
      --[[
    \   'width':  vim_get_option('columns'),
    \   'height': vim_get_option('lines'),
	]]
      -- row = math.floor((api.nvim_get_option("lines") - 10) / 10), -- Center vertically
      -- col = math.floor((api.nvim_get_option("columns") - 10) / 10), -- Center horizontally
      row = 1, -- Center vertically
      col = 1, -- Center horizontally
      border = "rounded", -- Optional: "single", "double", "rounded", "solid", "none"
      style = "minimal", -- Optional: "minimal" for no statusline/tabline
      focusable = true,
      zindex = 100, -- Bring the window to the front
    }

    local opt = opt or default_opt
    local buffer_exist = false
    local buffer
    local buf_counter

    for num_counter, buf_counter in ipairs(vim.api.nvim_list_bufs()) do
      local buf_name = vim.api.nvim_buf_get_name(buf_counter)
      -- print("name:" .. name)
      if buf_name == text_path then
        -- table.insert(buffers_to_keep, buf)
        -- buffer = buf_counter
        print("[already exists] " .. buf_name)
        -- print(" buffer: " .. buf_counter)
        -- print("   name: " .. buf_name)
        text_exist = true
      end
    end
    -- vim.notify("ABC")
    --

    -- local win_id = vim.api.nvim_open_win(buffer, true, opt)
    -- vim.api.nvim_win_set_buf(win_id, buffer)

    local win_id
    if buffer_exist then
      buffer = buf_counter
      win_id = vim.api.nvim_open_win(buffer, true, opt)
      -- vim.api.nvim_buf_call(buffer, vim.cmd.edit)
      vim.api.nvim_win_set_buf(win_id, buffer)
      -- buffer = buf_counter
    else
      buffer = vim.api.nvim_create_buf(true, false)
      win_id = vim.api.nvim_open_win(buffer, true, opt)
      -- vim.api.nvim_buf_set_name(buffer, text_path)
    end

    vim.api.nvim_buf_set_option(buffer, "filetype", "python")
    -- vim.api.nvim_buf_del_mark(buf, ".")

    --vim.api.nvim_del_mark(buffer, )
    --vim.api.nvim_buf_set_option(buf, "marks", false)
    -- vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
    --[[
    vim.keymap.set("n", "q", function()
      print("buf: buffer quiet.")
    end, { silent = true })
		]]

    --[[
    vim.keymap.set("i", "b", function()
      print("ABC")
    end, { expr = true, buffer = buf })
		]]
    -- vim.set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })

    --[[
		vim.keymap.set("n", "x", function()
  	  print("real lua function")
    end)
		]]
    -- vim.keymap.set("n", "q", vim.api.nvim_buf_delete, { buffer = buf })
    -- vim.keymap.set("n", "q", vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {}))
    -- local win_id = vim.api.nvim_open_win(buf, true, opt)

    -- vim.api.nvim_win_set_buf(win_id, buffer)

    vim.api.nvim_win_set_option(win_id, "number", false)
    vim.api.nvim_win_set_option(win_id, "relativenumber", false)
    vim.api.nvim_win_set_option(win_id, "wrap", true)
    vim.api.nvim_win_set_option(win_id, "cursorline", false)
    --     vim.api.nvim_win_set_option(win_id, "style", "minimal")
    vim.api.nvim_win_set_option(win_id, "signcolumn", "no")
    -- vim.api.nvim_win_set_option(win_id, "winhighlight", "FloatBorder:InputFloatBorder,NormalFloat:Normal")
    --[[
pumblend=10	補完などに使われるポップアップメニューを半透明に表示します。
winblend=10	任意の floating windows を半透明に表示します。
]]

    --[[
    vim.api.nvim_set_hl(win_id, "FloatBorder", {:q
      bg = "bg",
      fg = "#dddddd", -- floatのボーダーの色、:highlightで確認してね
    })
		]]
    api.nvim_win_set_option(win_id, "winhighlight", "FloatBorder:PopupMenuFloatBorder,NormalFloat:PopupMenuText")

    vim.api.nvim_win_set_option(win_id, "pumblend", 10)
    -- return buf, win_id
    vim.keymap.set({ "i", "n" }, "U", function()
      print("buf: " .. buf)
      vim.api.nvim_buf_call(buf, function()
        -- print("A")
      end)
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
      vim.api.nvim_win_close(win_id, false)
      -- vim.api.nvim_buf_delete(buf, {})
    end, {
      desc = [[buffer delete.]],
      expr = true,
      buffer = buf,
      noremap = true,
      silent = true,
    })

    --
    --
    return win_id, buffer
  end,
}

return M

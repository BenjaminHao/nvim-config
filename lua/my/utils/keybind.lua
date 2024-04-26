--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/utils/keybind.lua                                               │--
--│ DESC: function for key binds                                             │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keybind = {}

---@class map_rhs
---@field cmd string
---@field fun function
---@field options table
---@field options.noremap boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.nowait boolean
---@field options.buffer boolean|number
---@field options.desc string
local map_rhs = {}

function map_rhs:new()
  local instance = {
    cmd = "",
    fun = nil,
    options = {
      noremap = true,
      silent = true,
      expr = false,
      nowait = false,
      buffer = false,
      desc = "",
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_cr(cmd_string)
  self.cmd = (":%s<Cr>"):format(cmd_string)
  return self
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_args(cmd_string)
  self.cmd = (":%s<Space>"):format(cmd_string)
  return self
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_cu(cmd_string)
  -- <C-u> to eliminate the automatically inserted range in visual mode
  self.cmd = (":<C-u>%s<Cr>"):format(cmd_string)
  return self
end

---@param func fun():nil
--- Takes a function that will be called when the key is pressed
---@return map_rhs
function map_rhs:map_fun(func)
  self.fun = func
  return self
end

---@return map_rhs
function map_rhs:remap()
  self.options.noremap = false
  return self
end

---@return map_rhs
function map_rhs:echo()
  self.options.silent = false
  return self
end

---@param desc_string string
---@return map_rhs
function map_rhs:desc(desc_string)
  self.options.desc = desc_string
  return self
end

---@return map_rhs
function map_rhs:expr()
  self.options.expr = true
  return self
end

---@return map_rhs
function map_rhs:nowait()
  self.options.nowait = true
  return self
end

---@param num number
---@return map_rhs
function map_rhs:buffer(num)
  self.options.buffer = num
  return self
end

---@param cmd_string string
---@return map_rhs
function Keybind.map_cr(cmd_string)
  local ro = map_rhs:new()
  return ro:map_cr(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Keybind.map_cmd(cmd_string)
  local ro = map_rhs:new()
  return ro:map_cmd(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Keybind.map_cu(cmd_string)
  local ro = map_rhs:new()
  return ro:map_cu(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Keybind.map_args(cmd_string)
  local ro = map_rhs:new()
  return ro:map_args(cmd_string)
end

---@param func fun():nil
---@return map_rhs
function Keybind.map_fun(func)
  local ro = map_rhs:new()
  return ro:map_fun(func)
end

---@param cmd_string string
---@return string escaped_string
function Keybind.escape_termcode(cmd_string)
  return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

---@param mapping table<string, map_rhs>
function Keybind.set_nvim_keymap(mapping)
  for key, value in pairs(mapping) do
    local modes, keymap = key:match("([^|]*)|?(.*)")
    if type(value) == "table" then
      for _, mode in ipairs(vim.split(modes, "")) do
        local rhs = value.fun == nil and value.cmd or value.fun
        local options = value.options
        vim.keymap.set(mode, keymap, rhs, options)
      end
    end
  end
end

return Keybind

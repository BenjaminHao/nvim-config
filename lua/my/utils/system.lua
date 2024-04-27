--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/utils/system.lua                                                │--
--│ DESC: Utils for checking system and path                                 │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local System = {}

--- @class PathOperations
--- @field __div function The division operator overridden to concatenate file paths with the appropriate separator.
--- PathOperations metatable for overriding the division operator for strings.
local str_mt = getmetatable("") or {}
if not str_mt then setmetatable("", str_mt) end

--- Defines a custom division operator for strings to handle path concatenation.
-- This metamethod allows the use of the division operator to concatenate paths with the system's directory separator.
-- @param lhs string The first part of the path.
-- @param rhs string The second part of the path.
-- @return string The concatenated path using the system's directory separator.
-- @usage local path = "home" / "user" -- On Windows, this will result in "home\\user".
str_mt.__div = function(lhs, rhs)
  local separator = package.config:sub(1, 1)
  if type(lhs) == "string" and type(rhs) == "string" then
    return lhs .. separator .. rhs
  else
    error("Path separator only works on strings.")
  end
end

local os_name = vim.loop.os_uname().sysname
System.is_mac = os_name == "Darwin"
System.is_linux = os_name == "Linux"
System.is_windows = os_name == "Windows_NT"
System.is_wsl = vim.fn.has("wsl") == 1

local home = System.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
System.home_dir = home
System.cache_dir = home / ".cache" / "nvim"
System.data_dir = vim.fn.stdpath("data")
System.config_dir = vim.fn.stdpath("config")
System.plugin_dir = vim.fn.stdpath("config") / "lua" / "my" / "plugins"

return System

--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/utils/system.lua                                                │--
--│ DESC: Utils for checking system and path                                 │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local System = {}

local os_name = vim.loop.os_uname().sysname
System.is_mac = os_name == "Darwin"
System.is_linux = os_name == "Linux"
System.is_windows = os_name == "Windows_NT"
System.is_wsl = vim.fn.has("wsl") == 1

local separator = System.is_windows and "\\" or "/"
local home = System.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")

local path_mt = getmetatable("")
if path_mt == nil then
    path_mt = {}
    setmetatable("", path_mt)
end

function path_mt.__div(lhs, rhs)
    if type(lhs) == "string" and type(rhs) == "string" then
      return lhs .. separator .. rhs
    else
      error("Not all parameters are strings.")
    end
end

local function path(str)
  if type(str) == "string" then
    return str .. separator
  else
    error("Non-string value.")
  end
end

System.home_dir = path(home)
System.data_dir = path(vim.fn.stdpath("data"))
System.config_dir = path(vim.fn.stdpath("config"))
System.cache_dir = path(home/".cache"/"nvim")
System.plugin_dir = path(vim.fn.stdpath("config")/"lua"/"my"/"plugins")

return System

--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.keymaps.editor                                        │--
--│ DESC: Key binds for tool plugins                                         │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}

local misc = require("my.utils.misc")
local map_cr = require("my.utils.keybind").map_cr
local map_cu = require("my.utils.keybind").map_cu
local map_cmd = require("my.utils.keybind").map_cmd
local map_fun = require("my.utils.keybind").map_fun

Keymaps["treesj"] = {
  ["n|<tab>"] = map_fun(function() require("treesj").toggle() end):desc("Edit: Split/joining blocks of Code")
}

return Keymaps

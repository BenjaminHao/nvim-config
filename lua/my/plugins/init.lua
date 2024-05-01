--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.keymaps                                                       │--
--│ DESC: set up keymaps for plugins, others are handled by Lazy.nvim        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local keybind = require("my.utils.keybind")
local modules = require("my.utils.misc").get_modules_in_dir("my/plugins/keymaps")

local function set_plugin_keymap()
  for _, m in ipairs(modules) do
    local keymaps_list = require(m)
    if type(keymaps_list) == "table" then
      for plugin, keymaps in pairs(keymaps_list) do
        if type(plugin) == "string" then
          local ok, _ = pcall(require, plugin)
          if ok then keybind.set_nvim_keymap(keymaps) 
          else
            vim.notify(plugin .. " is not installed.")
          end
        end
      end
    end
  end
end

set_plugin_keymap()

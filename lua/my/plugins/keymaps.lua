--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.keymaps                                               │--
--│ DESC: Key binds for plugins                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}

local misc = require("my.utils.misc")
local keybind = require("my.utils.keybind")
local map_cr = keybind.map_cr
local map_cu = keybind.map_cu
local map_cmd = keybind.map_cmd
local map_fun = keybind.map_fun

local data = {
  ["nvim-tree"] = {
    ["n|<Leader>e"] = map_cr("NvimTreeToggle"):desc("Tool: File explorer"),
  },
  ["lazy"] = {
    ["n|<Leader>P"] = map_cr("Lazy"):desc("Tool: Plugin manager"),
  },
  ["telescope"] = {
    -- ["n|<C-p>"] = map_fun(function() misc.command_panel() end):desc("Tool: Toggle command panel"),
    ["n|<Leader>ff"] = map_cr("Telescope find_files"):desc("Find: Files"),
    ["n|<Leader>fh"] = map_cr("Telescope help_tags"):desc("Find: Help"),
    ["n|<Leader>fp"] = map_cr("Telescope projects"):desc("Find: Projects"),
    ["n|<Leader>fk"] = map_cr("Telescope keymaps"):desc("Find: Keymaps"),
    ["n|<Leader>fu"] = map_cr("Telescope undo"):desc("Find: Undo history"),
    ["n|<Leader>fb"] = map_cr("Telescope buffers"):desc("Find: Buffers"),
    ["n|<Leader>fd"] = map_cr("Telescope diagnostics"):desc("Find: Diagnostics"),
    ["n|<Leader>fw"] = map_cr("Telescope live_grep"):desc("Find: Word"),
    ["n|<Leader>fr"] = map_cr("Telescope oldfiles"):desc("Find: Recent File by history"),
    ["n|<Leader>fR"] = map_cr("Telescope frecency"):desc("Find: Recent File by frecency"),
    ["n|<Leader>f<Cr>"] = map_cr("Telescope resume"):desc("Find: Resume last find"),
    ["n|<leader>/"] = map_fun(function() require("telescope.builtin").current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false }) end):desc("Find: Word in current buffer"),
    ["v|<leader>f"] = map_fun(function() require("telescope.builtin").grep_string({ search = misc.buf_vtext() }) end):desc("Find: Selection"),
  },
  ["treesj"] = {
    ["n|<tab>"] = map_cr("TSJToggle"):desc("Edit: Split/joining blocks of Code")
  },
}

Keymaps.setup = function(plugin)
  if not vim.tbl_get(data, plugin) then
      vim.notify('Ignored: Missing keymap data for ["'.. plugin ..'"].',
        vim.log.levels.INFO, { title = "[my.plugins.keymaps] Runtime Info" })
  else
    keybind.set_nvim_keymap(data[plugin])
  end
end

return Keymaps

--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.keymaps.tool                                          │--
--│ DESC: Key binds for tool plugins                                         │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}

local misc = require("my.utils.misc")
local map_cr = require("my.utils.keybind").map_cr
local map_cu = require("my.utils.keybind").map_cu
local map_cmd = require("my.utils.keybind").map_cmd
local map_fun = require("my.utils.keybind").map_fun

Keymaps["nvim-tree"] = {
  ["n|<Leader>e"] = map_cr("NvimTreeToggle"):desc("Tool: Nvim-Tree"),
}

Keymaps["telescope"] = {
  ["n|<C-p>"] = map_fun(function() misc.command_panel() end):desc("Tool: Toggle command panel"),
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
  ["n|<leader>/"] = map_fun(function() 
    require("telescope.builtin").current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false })
  end):desc("Find: Word in current buffer"),
  ["v|<leader>f"] = map_fun(function()
    require("telescope.builtin").grep_string({ search = misc.buf_vtext() })
  end):desc("Find: Selection"),
}

return Keymaps

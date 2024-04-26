--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/editor/keymaps.lua                                              │--
--│ DESC: Custom key binds for editor                                        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}

local misc = require("my.utils.misc")
local keybind = require("my.utils.keybind")
local map_cr = keybind.map_cr
local map_cu = keybind.map_cu
local map_cmd = keybind.map_cmd
local map_fun = keybind.map_fun

local editor_keymaps = {
  ----------------------------- Better Defaults --------------------------------
  -- Keep cursor centered
  ["n|J"] = map_cmd("mzJ`z"):desc("Edit: Join next line"),
  ["n|n"] = map_cmd("nzzzv"):desc("Edit: Next search result"),
  ["n|N"] = map_cmd("Nzzzv"):desc("Edit: Prev search result"),
  ["n|<C-d>"] = map_cmd("<C-d>zz"):desc("Edit: Move screen down half pages"),
  ["n|<C-u>"] = map_cmd("<C-u>zz"):desc("Edit: Move screen up half pages"),
  ["n|<C-f>"] = map_cmd("<C-f>zz"):desc("Edit: Move screen down one page"),
  ["n|<C-b>"] = map_cmd("<C-b>zz"):desc("Edit: Move screen up one page"),
  -- better yanking
  ["v|d"] = map_cmd('"_d'):desc("Edit: Delete"), -- In visual mode, d for delete, x for cut
  ["n|D"] = map_cmd("d$"):desc("Edit: Delete text to EOL"),
  ["n|dd"] = map_fun(function() return misc.is_empty_line() and '"_dd' or "dd" end):expr():desc("Edit: Delete line"),
  ["n|x"] = map_cmd('"_x'):desc("Edit: Delete a character"), -- Do not copy deleted character
  ["n|Y"] = map_cmd("y$"):desc("Edit: Yank text to EOL"),
  ["v|p"] = map_cmd('"_dP'):desc("Edit: Paste"), -- Visual overwrite paste
  -- Indenting
  ["v|<"] = map_cmd("<gv"):desc("Edit: Decrease indent"),
  ["v|>"] = map_cmd(">gv"):desc("Edit: Increase indent"),
  ["n|i"] = map_fun(function() return misc.is_empty_line() and "S" or "i" end):expr():desc("Edit: Insert"),
  -- Movement
  ["ic|<C-h>"] = map_cmd("<Left>"):desc("Edit: Move cursor left"),
  ["ic|<C-j>"] = map_cmd("<Down>"):desc("Edit: Move cursor down"),
  ["ic|<C-k>"] = map_cmd("<Up>"):desc("Edit: Move cursor up"),
  ["ic|<C-l>"] = map_cmd("<Right>"):desc("Edit: Move cursor right"),
  ["ic|<C-a>"] = map_cmd("<Home>"):desc("Edit: Move cursor to line start"),
  ["ic|<C-e>"] = map_cmd("<End>"):desc("Edit: Move cursor to line end"),
  ["ic|<C-d>"] = map_cmd("<Del>"):desc("Edit: Delete"),
  ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):desc("Edit: Delete previous block"),
  ["i|<C-,>"] = map_cmd("<End>,"):desc("Edit: Add comma to line end"),
  ["i|<C-;>"] = map_cmd("<End>;"):desc("Edit: Add semicolon to line end"),
  ["i|<C-CR>"] = map_cmd("<End><CR>"):desc("Edit: Start a new line"),
  -- Move Lines
  ["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):desc("Edit: Move this line down"),
  ["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):desc("Edit: Move this line up"),
  -- Others
  ["n|<Esc>"] = map_fun(function() misc.flash_esc_or_noh() end):desc("Edit: Clear search highlight"),
  ["n|<S-Tab"] = map_cr("normal za"):desc("Edit: Toggle code fold"),
  ["n|<Leader>w"] = map_cu("write"):desc("Edit: Write file"),
  ["n|<Leader>q"] = map_cr("wq"):desc("Edit: Save file and quit"),
  ["n|<Leader>Q"] = map_cr("q!"):desc("Edit: Force quit"),
  -- ["n|<Leader>ts"] = map_cr("setlocal spell! spelllang=en_us"):desc("Edit: Toggle spell check"),
  ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):desc("Edit: Complete path of current file"),
  --------------------------------- Windows ------------------------------------
  ["n|<C-h>"] = map_cmd("<C-w>h"):desc("Windows: Focus left"),
  ["n|<C-l>"] = map_cmd("<C-w>l"):desc("Windows: Focus right"),
  ["n|<C-j>"] = map_cmd("<C-w>j"):desc("Windows: Focus down"),
  ["n|<C-k>"] = map_cmd("<C-w>k"):desc("Windows: Focus up"),
  ["n|<A-h>"] = map_cr("vertical resize -3"):desc("Windows: Resize -3 vertically"),
  ["n|<A-l>"] = map_cr("vertical resize +3"):desc("Windows: Resize +3 vertically"),
  ["n|<A-j>"] = map_cr("resize -3"):desc("Windows: Resize -3 horizontally"),
  ["n|<A-k>"] = map_cr("resize +3"):desc("Windows: Resize +3 horizontally"),
  ------------------------------ Terminal Mode----------------------------------
  ["t|<C-w>h"] = map_cmd("<Cmd>wincmd h<CR>"):desc("Windows: Focus left"),
  ["t|<C-w>l"] = map_cmd("<Cmd>wincmd l<CR>"):desc("Windows: Focus right"),
  ["t|<C-w>j"] = map_cmd("<Cmd>wincmd j<CR>"):desc("Windows: Focus down"),
  ["t|<C-w>k"] = map_cmd("<Cmd>wincmd k<CR>"):desc("Windows: Focus up"),
}

Keymaps.set_leader_key = function()
  -- <Space> is <Leader>
  vim.g.mapleader = " "
end

Keymaps.set_editor_keymaps = function()
  keybind.set_nvim_keymap(editor_keymaps)
end

return Keymaps

--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  FILE: init.lua                                                          │--
--│  DESC: Entry point of Neovim config                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local editor_startup = require("my.editor.startup")
local editor_options = require("my.editor.options")
local editor_keymaps = require("my.editor.keymaps")
local editor_autocmd = require("my.editor.autocmd")
local editor_manager = require("my.editor.manager")

editor_startup.set_startup_config()
editor_options.set_editor_options()
editor_keymaps.set_leader_key()
editor_keymaps.set_editor_keymaps()
editor_autocmd.set_autocmd()
editor_manager.load_lazy()
require"my.plugins"

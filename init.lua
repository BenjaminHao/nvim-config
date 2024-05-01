--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  FILE: init.lua                                                          │--
--│  DESC: Entry point of Neovim config                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local editor_startup = require("my.editor.startup")
local editor_options = require("my.editor.options")
local editor_autocmd = require("my.editor.autocmd")
local editor_keymaps = require("my.editor.keymaps")
local plugin_manager = require("my.plugins.manager")

editor_startup.setup()
editor_options.setup()
editor_autocmd.setup()
editor_keymaps.setup()
plugin_manager.setup()

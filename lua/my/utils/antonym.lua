--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.utils.antonym.lua                                             │--
--│ DESC: toggle reserve terms                                               │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Antonym = {}

---@usage Put lower case antonyms here. Final table will include capitalized & upper case strings.
local data = {
    ["true"] = "false",
    ["yes"] = "no",
    ["on"] = "off",
    ["left"] = "right",
    ["up"] = "down",
    ["top"] = "bottom",
    ["vertical"] = "horizontal",
    ["before"] = "after",
    ["first"] = "last",
    ["enable"] = "disable",
    ["enabled"] = "disabled",
}

local get_antonym_tbl = function()
  local antonym_table = {}
  local capitalize = require("my.utils.misc").capitalize_string
  for key, value in pairs(data) do
    antonym_table[key] = value
    if string.find(key, "%a") and string.find(value, "%a") then
      antonym_table[string.upper(key)] = string.upper(value)
      antonym_table[capitalize(key)] = capitalize(value)
    end
  end
  return vim.tbl_add_reverse_lookup(antonym_table)
end

---Get antonyms.
Antonym.toggle = function()
  local terms = get_antonym_tbl()
  local commands = {
    ["n"] = "norm! ciw",
    ["v"] = "norm! c",
  }
  local inverted = vim.tbl_get(terms, vim.fn.expand("<cword>"))
  xpcall(function()
    vim.cmd(vim.tbl_get(commands, vim.api.nvim_get_mode().mode) .. inverted)
  end, function()
      vim.notify(
        [[
This term cannot be inverted, or cannot find data in antonym table.

Please double check the word you selected:
  1. Only full lowercase, capitalized, and full uppercase terms supported.
  2. Normal mode: using <ciw> command.
  3. Visual mode: using <c> command.

If nothing wrong, you may want to add the term into antonym table:
  Please modify data table in "my.utils.antonym"]],
        vim.log.levels.WARN,
        { title = "[my.utils.antonym] Runtime Warning" }
      )
    end)
end

------------------------------- TEST FIELD -------------------------------------
-- TRUE
-- True
-- true
-- tRue

return Antonym

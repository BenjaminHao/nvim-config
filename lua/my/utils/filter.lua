--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.utils.filter.lua                                              │--
--│ DESC: filter table for strings                                           │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Filter = {}
local capitalize = require("my.utils.misc").capitalize_string

local data = {
  which_key_hidden = {
    "<silent>",
    "<cmd>",
    "<cr>",
    "^:",
    "^ ",
    "^call ",
    "^lua ",
  },
  telescope_ignore_file = {
    "%.class",
    "%.exe",
    "%.jpeg",
    "%.jpg",
    "%.mkv",
    "%.mp4",
    "%.pdf",
    "%.png",
    "%.zip",
    ".cache",
    ".git/",
    "build/",
    "node_modules",
  },
}

local function get_variant_tbl(tbl)
  local variant_table = {}
  if not vim.tbl_islist(tbl) then
    error("filter.get(): Variant only works on list like tables.")
  end
  for i, str in ipairs(tbl) do
    table.insert(variant_table, str)
    if string.find(str, "%a") then
      table.insert(variant_table, capitalize(str))
      table.insert(variant_table, string.upper(str))
    end
  end
  return variant_table
end

---Get filter strings in a table.
---@param category "which_key_hidden"|"telescope_ignore_file"
---@param variant? boolean Whether to make table include String & STRING.
---@return table The table that contains filter strings for specific category.
Filter.get = function(category, variant)
  if variant then
    return get_variant_tbl(data[category])
  else
    return data[category] 
  end
end

return Filter

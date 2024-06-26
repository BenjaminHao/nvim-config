--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/utils/misc.lua                                                  │--
--│ DESC: misc utils                                                         │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Misc = {}

Misc.is_empty_line = function()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('^%s*$') ~= nil
end

Misc.capitalize_string = function(str)
  return (str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper()..rest
  end, 1))
end

Misc.command_panel = function()
  require("telescope.builtin").keymaps({
    lhs_filter = function(lhs)
      return not string.find(lhs, "Þ")
    end,
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = "top",
    },
  })
end

Misc.esc_flash_or_noh = function()
  local flash_active, state = pcall(function()
    return require("flash.plugins.char").state
  end)
  if flash_active and state then
    state:hide()
  else
    pcall(vim.cmd.noh)
  end
end

local lazygit = nil
Misc.toggle_lazygit = function()
  if vim.fn.executable("lazygit") == 1 then
    if not lazygit then
      lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        direction = "float",
        close_on_exit = true,
        hidden = true,
      })
    end
    lazygit:toggle()
  else
    vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
  end
end

-- TODO: Update this function to use `vim.getregion()` when v0.10 is released.
Misc.buf_vtext = function()
  local a_orig = vim.fn.getreg("a")
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg("a")
  vim.fn.setreg("a", a_orig)
  return text
end

---Get modules list under the path
---@param path string Path string starting with "my/"
---@return table Returns a table contains modules list in that path (in . form)
---@usage get_modules_in_dir("my/plugins") will get a table contains lua modules in my/plugins dir.
Misc.get_modules_in_dir = function(path)
  local module_list = {}
  local prefix = path:gsub("/", ".") .. "."
  local file_list = vim.split(
    vim.fn.glob(vim.fn.stdpath("config") .. "/lua/" .. path .. "/*.lua"),
    "\n"
  )
  for _, file in ipairs(file_list) do
    table.insert(module_list, prefix .. vim.fn.fnamemodify(file, ":t"):sub(0, -5))
  end

  return module_list
end

return Misc

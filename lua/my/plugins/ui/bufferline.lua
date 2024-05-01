--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.ui.bufferline                                         │--
--│ DESC: UI plugin for buffers                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.bufremove" },
    { "nvim-tree/nvim-web-devicons" },
  },
}

Plugin.config = function()
  local bufferline = require("bufferline")
  local bufremove = require("mini.bufremove")

  bufferline.setup({
    options = {
      mode = "buffers",
      themable = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
      style_preset = bufferline.style_preset.minimal,
      -- separator_style = "slant",
      numbers = function(opts)
        return string.format("%s", opts.raise(opts.ordinal))
      end,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      close_command = function(n) bufremove.delete(n, false) end,
      diagnostics = false,           -- OR: | "nvim_lsp" 
      diagnostics_update_in_insert = false,
      sort_by = "insert_at_end",
      hover = {
        enabled = true,
        delay = 30,
        reveal = { 'close' }
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "NvimTree",
          -- text = function()
          --   return vim.fn.fnamemodify(".", ":p:h:t")
          --   -- return vim.fn.getcwd()
          -- end,
          -- highlight = "Directory",
          separator = false, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  })
end

return Plugin

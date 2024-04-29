--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.which-key                                        │--
--│ DESC: showing pending key binds                                          │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"

Plugin.init = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
end

Plugin.config = function()
  local wk = require("my.utils").load_plugin("which-key")
  local hidden_key = require("my.utils.filter").get("which_key_hidden", true)
  local icons = {
    ui = require("my.utils.icons").get("ui"),
    misc = require("my.utils.icons").get("misc"),
    git = require("my.utils.icons").get("git", true),
    cmp = require("my.utils.icons").get("cmp", true),
 }

  -------------------------- Which-key Config ----------------------------------
  wk.setup({
    plugins = {
      marks = true,           -- shows a list of your marks on ' and `
      registers = true,         -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,         -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 10,
      },
      presets = {
        operators = false,    -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
      },
    },
    key_labels = {
      -- ["<leader>"] = "󱁐",
      ["<space>"] = "󱁐",
      ["<CR>"] = "󰌑",
      ["<tab>"] = "󰌒",
      ["<bs>"] = "󰌍",
      ["<esc>"] = "󱊷",
    },
    icons = {
      breadcrumb = icons.ui.Separator,
      separator = icons.misc.Vbar,
      group = "",
    },
    window = {
      border = "shadow",
      margin = { 1, 2, 1, 2 },
      padding = { 1, 2, 1, 2 },
    },
    hidden = hidden_key,
  })

  -------------------------- Which-key Labels ----------------------------------
  -- Document existing key chains
  wk.register({
    ["<leader>"] = {
      S = {
        "z=", "Spelling", noremap = false,
      },
      b = {
        name = icons.ui.Buffer .. " Buffer", _ = "which_key_ignore"
      },
      f = {
        name = icons.ui.Telescope .. " Find", _ = "which_key_ignore"
      },
      g = {
        name = icons.git.Git .. "Git", _ = "which_key_ignore"
      },
      l = {
        name = icons.misc.LspAvailable .. " Lsp", _ = "which_key_ignore"
      },
    }
  })

end

return Plugin

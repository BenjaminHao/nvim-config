--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ Module: my.plugins.manager                                               │--
--│ Desc: Lazy.nvim as plugin manager                                        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Manager = {}

local system = require("my.utils.system")
local icons = {
  kind = require("my.utils.icons").get("kind"),
  documents = require("my.utils.icons").get("documents"),
  ui = require("my.utils.icons").get("ui"),
  ui_sep = require("my.utils.icons").get("ui", true),
  misc = require("my.utils.icons").get("misc"),
  misc_sep = require("my.utils.icons").get("misc", true),
}

local function bootstrap_lazy()
  local lazy_repo = "https://github.com/folke/lazy.nvim.git"
  local lazy_path = system.data_dir / "lazy" / "lazy.nvim"

  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable", -- latest stable release
      lazy_repo,
      lazy_path,
    })
  end

  vim.opt.rtp:prepend(lazy_path)
end

local function setup_lazy()
  local lazy_config = {
    root = system.data_dir / "lazy", -- directory where plugins will be installed
    defaults = {
      lazy = true,
    },
    spec = {
      { import = "my.plugins.edit" },
      { import = "my.plugins.tool" },
      { import = "my.plugins.ui" },
    },
    lockfile = system.config_dir / "lazy-lock.json",
    confurrency = system.is_mac and 20 or nil,
    install = {
      colorscheme = { "catppuccin" },
    },
    ui = {
      border = "shadow",
      icons = {
        cmd = icons.misc.Code,
        config = icons.ui.Gear,
        event = icons.misc_sep.Bell_ring,
        lazy = icons.misc_sep.Bell_sleep,
        ft = icons.documents.Files,
        init = icons.misc.ManUp,
        import = icons.documents.Import,
        keys = icons.ui.Keyboard,
        loaded = icons.ui.Check_alt,
        not_loaded = icons.ui.Uncheck_alt,
        plugin = icons.ui.Package,
        task = icons.misc.Task,
        runtime = icons.misc.Vim,
        source = icons.kind.StaticMethod,
        start = icons.ui.Play,
        list = {
          icons.ui_sep.Circle,
          icons.ui_sep.Circle_alt,
          icons.ui_sep.Square,
          icons.ui_sep.ChevronRight,
        },
      },
    },
    performance = {
      cache = {
        enabled = true,
        path = system.cache_dir / "lazy" / "cache",
        -- Once one of the following events triggers, caching will be disabled.
        -- To cache all modules, set this to `{}`, but that is not recommended.
        disable_events = { "UIEnter", "BufReadPre" },
        ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
      },
      rtp = {
        -- Disable default plugins
        disabled_plugins = {
          "2html_plugin",
          "tohtml",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "syntax",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  }
  require("lazy").setup(lazy_config)
  require("my.plugins.keymaps").setup("lazy")
end

Manager.setup = function()
  bootstrap_lazy()
  setup_lazy()
end

return Manager

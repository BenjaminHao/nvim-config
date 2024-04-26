--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.telescope                                        │--
--│ DESC: Fuzzy finder plugin                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "[b]uffers" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>",  desc = "[d]iagnostics" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "[f]iles" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "[g]rep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "[h]elp" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",  desc = "[k]eymaps" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",  desc = "[r]ecent files" },
    { "<leader>fa", "<cmd>Telescope builtin<cr>",  desc = "[a]ll" },
    { "<leader>fu", "<cmd>Telescope undo<cr>",  desc = "[u]ndo" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>",  desc = "[w]ord" },
    { "<leader>f<leader>", "<cmd>Telescope resume<cr>",  desc = "[RESUME]" },
    -- Shortcut for searching your neovim configuration files
    { "<leader>fn", function()
      require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath "config",
        prompt_title = "Find Neovim Config Files",
      } end,
      desc = "[n]eovim config"
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()  -- determine if this should be installed and loaded
        return vim.fn.executable "make" == 1
      end,
    },
    "nvim-tree/nvim-web-devicons",
  },
}

Plugin.config = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local undo = require("telescope-undo.actions")
  local icons = { ui = require("my.utils.icons").get("ui", true) }

  telescope.setup({
    ----------------------------- builtin ---------------------------------------
    defaults = {
      path_display = { "smart" },
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = " ",
      entry_prefix = " ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      file_ignore_patterns = { "node_modules", "^.git/" },
      dynamic_preview_title = true,
      winblend = 0,
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.55,
          width = 0.80,
          preview_cutoff = 120,
          prompt_position = "bottom",
        },
        vertical = {
          height = 0.80,
          preview_cutoff = 40,
          mirror = true,
          prompt_position = "bottom",
        },
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-l>"] = actions.select_default,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-u>"] = actions.preview_scrolling_up,
        },
        n = {
          ["q"] = actions.close,
          ["?"] = actions.which_key,
        },
      },
    },
    ---------------------------- extensions ----------------------------------
    load_extension = {
      "fzf",
      "yank_history",
      "undo",
      "lazygit"
    },
    extensions_list = { "themes" },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      undo = {
        mappings = {
          i = {
            ["<C-a>"] = undo.yank_additions,
            ["<C-d>"] = undo.yank_deletions,
            ["<C-u>"] = undo.restore,
          },
          n = {
            ["y"] = undo.yank_additions,
            ["Y"] = undo.yank_deletions,
            ["u"] = undo.restore,
          },
        },
      },
    },
  })
end

return Plugin

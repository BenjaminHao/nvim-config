--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.telescope                                        │--
--│ DESC: Fuzzy finder plugin                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.branch = "0.1.x"

Plugin.cmd = "Telescope"

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" }, -- lua functions library
    { "ahmedkhalf/project.nvim" }, -- TODO: lazy loading
    { "nvim-tree/nvim-web-devicons" },  -- icons for ui
    { "debugloop/telescope-undo.nvim" }, -- fuzzy-search undo tree
    { "nvim-telescope/telescope-frecency.nvim" }, -- sorting by frequency and recency
    { "nvim-telescope/telescope-live-grep-args.nvim" }, -- live grep args picker
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- a C port of fzf, Cmake required
    -- TODO: check { "jvgrootveld/telescope-zoxide" },
}

Plugin.config = function()
  local telescope = require("my.utils").load_plugin("telescope")
  local actions = require("my.utils").load_plugin("telescope.actions")
  local lga_actions = require("my.utils").load_plugin("telescope-live-grep-args.actions")
  local undo_actions = require("my.utils").load_plugin("telescope-undo.actions")
  local project = require("my.utils").load_plugin("project_nvim")
  local icons = { ui = require("my.utils.icons").get("ui", true) }
  local file_filter = require("my.utils.filter").get("telescope_ignore_file")

  telescope.setup({
    ----------------------------- builtin ---------------------------------------
    defaults = {
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.ChevronRight,
      path_display = { "absolute" },
      sorting_strategy = "ascending",
      results_title = false,
      set_env = { COLORTERM = "truecolor" },
      file_ignore_patterns = file_filter,
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          width = 0.8,
          preview_cutoff = 120,
        },
        vertical = {
          prompt_position = "bottom",
          height = 0.8,
          preview_cutoff = 40,
          mirror = true,
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
      "frecency",
      "fzf",
      "lazygit",
      "live_grep_args",
      "notify",
      "projects",
      "undo",
      "yank_history",
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
      },
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
      undo = {
        side_by_side = true,
        mappings = {
          i = {
            ["<Cr>"] = undo_actions.yank_additions,
            ["<S-Cr>"] = undo_actions.yank_deletions,
            ["<C-Cr>"] = undo_actions.restore,
          },
          n = {
            ["<Cr>"] = undo_actions.yank_additions,
            ["<S-Cr>"] = undo_actions.yank_deletions,
            ["<C-Cr>"] = undo_actions.restore,
          },
        },
      },
    },
  })

  ----------------------------- Project.nvim -----------------------------------
  project.setup({ ignore_lsp = { "null-ls", "copilot" } })
end

return Plugin

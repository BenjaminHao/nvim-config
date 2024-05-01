--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.editor.nvim-treesitter                                │--
--│ DESC: Syntax highlighting plugin (a C complier is required)              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "Wansmer/treesj" }, -- for splitting/joning blocks of code
    { "windwp/nvim-ts-autotag" },
    { "nvim-treesitter/nvim-treesitter-textobjects" }, -- syntax aware text-objects
  },
}

Plugin.init = function()
  require("my.plugins.keymaps").setup("treesj")
end

Plugin.config = function()
  local treesitter = require("nvim-treesitter.configs")
  local treesj = require("treesj")

  --------------------------- Treesitter Setup -------------------------------
  treesitter.setup({
    highlight = {
      enable = true,            -- enable syntax highlighting
      additional_vim_regex_highlighting = false, -- prevent wrong highlighting
      disable = {},             -- list of language that will be disabled
    },
    indent = {
      enable = true,            -- enable indentation
    },
    autotag = {
      enable = true,            -- enable autotagging (w/ nvim-ts-autotag plugin)
    },
    autopairs = {
      enable = true,            -- enable autopairs
    },
    auto_install = true,
    ensure_installed = {        -- ensure these language parsers are installed
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "sql",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- TODO: Treesitter textobject key binds
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["at"] = "@class.outer",
          ["it"] = "@class.inner",
          ["ac"] = "@call.outer",
          ["ic"] = "@call.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["a/"] = "@comment.outer",
          ["i/"] = "@comment.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@scopename.inner",
          ["aA"] = "@attribute.outer",
          ["iA"] = "@attribute.inner",
          ["aF"] = "@frame.outer",
          ["iF"] = "@frame.inner",
        },
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  })

  ---------------------------- Treesj Config ---------------------------------
  treesj.setup({
    use_default_keymaps = false,
  })

end

return Plugin

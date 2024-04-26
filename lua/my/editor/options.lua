--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: my/editor/options.lua                                              │--
--│ DESC: basic options for Neovim                                           │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Options = {}
local system = require("my.utils.system")

local global_options = {

  -- GENERAL
  timeoutlen = 500,                      -- Time to wait for a mapped sequence to complete (in milliseconds)
  ttimeoutlen = 0,                       -- Time to wait for a key code to complete (in milliseconds)
  updatetime = 200,                      -- Faster completion (4000ms default)
  swapfile = false,                      -- Creates a swapfile
  undofile = true,                       -- Enable persistent undo
  undodir = system.cache_dir .. "undo/", -- Set undo dictionary
  writebackup = false,                   -- If a file is being edited by another program, it is not allowed to be edited
  mouse = "a",                           -- Allow the mouse to be used in neovim
  mousescroll = "ver:2,hor:4",           -- Change the speed of the scroll wheel
  jumpoptions = "stack",                 -- Make Ctrl-o consistent

  -- APPEARANCE
  guifont =
    "JetBrainsMono Nerd Font:h16",       -- Font for GUI NVIM
  number = true,                         -- Set numbered lines
  relativenumber = true,                 -- Set relative numbered lines
  numberwidth = 2,                       -- Set number column width to 2 (default 4)
  cursorline = true,                     -- Highlight the current line
  cursorcolumn = false,                  -- Highlight the current column (default false)
  colorcolumn = "80",                    -- Set a column ruler
  wrap = false,                          -- no line wrap, display lines as one long line
  showbreak = " ",                       -- Set indent of wrapped lines
  fileencoding = "utf-8",                -- The encoding written to a file
  background = "dark",                   -- Colorschemes that can be light or dark will be made dark
  termguicolors = true,                  -- Set term gui colors (most terminals support this)
  conceallevel = 0,                      -- So that `` is visible in markdown files
  signcolumn = "yes",                    -- Always show the sign column, otherwise it would shift the text each time
  cmdheight = 1,                         -- Space in the neovim command line for displaying messages
  pumheight = 7,                         -- Pop up menu height
  showmode = false,                      -- We don't need to see things like -- INSERT -- anymore
  splitbelow = true,                     -- Force all horizontal splits to go below current window
  splitright = true,                     -- Force all vertical splits to go to the right of current window
  scrolloff = 7,                         -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 7,                     -- Minimal number of screen columns either side of cursor if wrap is `false`
  shortmess = "filnxtToOFc",             -- Which errors to suppress
  list = true,                           -- Display certain whitespace in the editor
  listchars =                            -- Symbols for whitespace
    { tab = "»·",                           -- The characters used to show a tab (need 2 characters)
      trail = "·",                          -- Character to show for trailing spaces
      nbsp = "␣" ,                          -- Character to show for non-breaking space
      extends = "→",                        -- Character to show there"s more text to the right (when no line wrap)
      precedes = "←",                       -- Character to show there"s more text to the left
    },

  -- INDENT
  tabstop = 2,                           -- Insert 2 spaces for a tab (for specific language setting, see autocmds.lua
  softtabstop = 2,                       -- Insert 2 spaces for a tab
  shiftwidth = 2,                        -- The number of spaces inserted for each indentation
  expandtab = true,                      -- Convert tabs to spaces
  autoindent = true,                     -- Auto indent
  smartindent = true,                    -- Smart indent
  backspace = "indent,eol,start",        -- Allow backspace on indent, end of line or insert mode start position

  -- EDIT
  spell = false,                         -- Spellchecker
  spelllang = { "en_us" },               -- Sets spelling dictionary
  clipboard = "unnamedplus",             -- Allows neovim to access the system clipboard
  ignorecase = true,                     -- Ignore case in search patterns
  smartcase = true,                      -- Smart case
  virtualedit = "block",                 -- Vitualblock mode doesn't get stuck at the end of line
  inccommand = "split",                  -- Shows all inline replacements in split
}

local neovide_options = {
  no_idle = true,                        -- Force neovide to redraw all the time
  refresh_rate = 60,                     -- Set neovide fps, only effective when not using vsync
  cursor_vfx_mode = "railgun",           -- Cursor particles: "railgun"|"torpedo"|"pixiedust"|"sonicboom"|"ripple"|"wireframe"
  cursor_vfx_opacity = 200.0,            -- Set cursor particle opacity
  cursor_antialiasing = true,            -- Enables or disables antialiasing of the cursor quad
  cursor_trail_size = 0.5,               -- Determines how much the trail of the cursor lags behind the front edge
  cursor_animation_length = 0.1,         -- Determines the time it takes for the cursor to complete it's animation in seconds
  cursor_vfx_particle_speed = 20.0,      -- Sets the speed of particle movement
  cursor_vfx_particle_density = 5.0,     -- Sets the number of generated particles
  cursor_vfx_particle_lifetime = 1.2,    -- Sets the amount of time the generated particles should survive
}

Options.set_editor_options = function()
  for option, value in pairs(global_options) do
    vim.opt[option] = value
  end

  if vim.g.neovide then
    for name, config in pairs(neovide_options) do
      vim.g["neovide_" .. name] = config
    end
  end
end

return Options

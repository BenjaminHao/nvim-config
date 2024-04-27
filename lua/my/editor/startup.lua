--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.editor.startup                                                │--
--│ DESC: Initial setup for editor                                           │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Startup = {}
local system =  require("my.utils.system")

local function create_cache_dir()
  local data_dir = {
    system.cache_dir / "backup",
    system.cache_dir / "session",
    system.cache_dir / "swap",
    system.cache_dir / "tags",
    system.cache_dir / "undo",
  }
  -- Only check whether cache_dir exists, this would be enough.
  if vim.fn.isdirectory(system.cache_dir) == 0 then
    os.execute("mkdir -p " .. system.cache_dir)
    for _, v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

local function set_clipboard_config()
  if system.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
      cache_enabled = 0,
    }
  elseif system.is_wsl then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  end
end

local function set_shell_config()
  if system.is_windows then
    if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
      vim.notify(
        [[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
        vim.log.levels.WARN,
        { title = "[EDITOR] Runtime Warning" }
      )
      return
    end

    local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
    local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
    vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag = string.format("%s %s;", basecmd, ctrlcmd)
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = nil
    vim.opt.shellxquote = nil
  end
end

Startup.set_startup_config = function()
  create_cache_dir()
  set_clipboard_config()
  set_shell_config()
end

return Startup

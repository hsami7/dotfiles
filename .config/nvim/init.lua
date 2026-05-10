-- ~/.config/nvim/init.lua

-- 1. Load Core Settings First
-- It is critical to load options and keymaps BEFORE plugins
-- so that your leader key (' ') is ready when plugins try to use it.
require 'core.options' -- Sets up your numbers, tabs, etc.
require 'core.keymaps' -- Sets up your leader and basic shortcuts
require 'core.diagnostics' -- Sets up your diagnostics and appearance

-- 2. Bootstrap Lazy.nvim (Plugin Manager)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Setup Plugins via Lazy
-- We use 'spec' with 'import' so you don't have to manually list every file.
-- This will automatically load everything in your lua/plugins/ directory.
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  -- Configure Lazy UI appearance
  ui = {
    border = 'rounded',
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  -- Automatically check for plugin updates
  checker = { enabled = true, notify = false },
  -- This will use the colorscheme you set in plugins/colortheme.lua for the lazy UI
  -- install = { colorscheme = { 'tokyonight' } },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et- vim: ts=2 sts=2 sw=2 et

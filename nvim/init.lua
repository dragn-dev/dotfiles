require 'core.options'
require 'core.snippets'
require 'core.keymaps'

-- require 'core.autocmds'

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup({
  require 'plugins.neo-tree',
  require 'plugins.snacks',
  require 'plugins.autocompletion',
  require 'plugins.colorscheme',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.misc',
  require 'plugins.kickStart-lsp',
  require 'plugins.null',
  require 'plugins.tree-sitter',
}, {
  checker = { enabled = false },
  change_detection = { enabled = false, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'matchit', 'matchparen', 'netrwPlugin',
        'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
})

return {
  {
    'folke/which-key.nvim', -- shows the keybinds
    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    -- Easily comment visual regions/lines
    'numToStr/Comment.nvim',
    keys = {
      { '<C-_>', mode = { 'n', 'v' } },
      { '<C-c>', mode = { 'n', 'v' } },
      { '<C-/>', mode = { 'n', 'v' } },
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
    config = function()
      require('Comment').setup()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, opts)
      vim.keymap.set('n', '<C-c>', require('Comment.api').toggle.linewise.current, opts)
      vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, opts)
      vim.keymap.set('v', '<C-_>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
      vim.keymap.set('v', '<C-c>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
      vim.keymap.set('v', '<C-/>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
}

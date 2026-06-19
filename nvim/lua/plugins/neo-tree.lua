return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'Neotree reveal' },
    { '<leader>e', ':Neotree toggle position=left<CR>', desc = 'Neotree toggle' },
    { '<leader>ngs', ':Neotree float git_status<CR>', desc = 'Neotree git status' },
  },
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      desc = 'Open Neo-tree when nvim starts on a directory',
      group = vim.api.nvim_create_augroup('NeotreeStartDirOpen', { clear = true }),
      callback = function(args)
        local stats = vim.uv.fs_stat(args.file)
        if stats and stats.type == 'directory' then
          vim.api.nvim_del_augroup_by_name('NeotreeStartDirOpen')
          require('neo-tree.command').execute { action = 'show', dir = args.file }
        end
      end,
    })
  end,
  opts = {
    popup_border_style = 'rounded',
    default_component_configs = {
      preview = {
        enabled = true,
        backend = 'image.nvim',
        image_backend = 'kitty',
      },
    },
    window = {
      mappings = {
        ['P'] = { 'toggle_preview', config = { use_float = true } },
        ['l'] = 'open',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
      },
    },
    filesystem = {
      filtered_items = {
        hide_by_name = {
          '.DS_Store',
          'thumbs.db',
          'node_modules',
          '__pycache__',
          '.virtual_documents',
          '.git',
          '.python-version',
          '.venv',
        },
      },
    },
    buffers = {
      follow_current_file = { enabled = true },
      group_empty_dirs = true,
      show_unloaded = true,
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
      },
    },
  },
}

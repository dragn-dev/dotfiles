return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  keys = {
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Prev todo' },
    { '<leader>st', '<cmd>TodoLocList<cr>', desc = 'Todo list' },
  },
}

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      show_buffer_close_icons = true,
      show_close_icon = false,
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    { "<leader>bx", "<cmd>bdelete<cr>", desc = "Close buffer" },
  },
}

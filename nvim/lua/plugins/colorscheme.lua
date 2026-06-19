return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      background = { dark = 'mocha' },
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { 'italic' },
        keywords = { 'italic' },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}

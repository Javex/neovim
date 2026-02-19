return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  config = function() vim.cmd.colorscheme 'catppuccin' end,
}

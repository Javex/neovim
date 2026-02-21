return {
  'catppuccin/nvim',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  name = 'catppuccin',
  priority = 1000,
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  config = function() vim.cmd.colorscheme 'catppuccin' end,
}

return {
  'lukas-reineke/indent-blankline.nvim',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = { char = '│' },
    scope = { char = '│' },
  },
}

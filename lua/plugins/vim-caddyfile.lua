return {
  'isobit/vim-caddyfile',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  -- Empty options are necessary as otherwise the setup function won't be
  -- called.
  opts = {},
  event = {
    'BufRead Caddyfile, *.Caddyfile',
    'BufNewFile Caddyfile, *.Caddyfile',
  },
}

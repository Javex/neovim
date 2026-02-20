return {
  'isobit/vim-caddyfile',
  -- Empty options are necessary as otherwise the setup function won't be
  -- called.
  opts = {},
  event = {
    'BufRead Caddyfile, *.Caddyfile',
    'BufNewFile Caddyfile, *.Caddyfile',
  },
}

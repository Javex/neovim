return {
  'pearofducks/ansible-vim',
  -- Empty options are necessary as otherwise the setup function won't be
  -- called.
  opts = {},
  event = {
    'BufRead *.yaml,*.yml,*.j2',
    'BufNewFile *.yaml,*.yml,*.j2',
  },
}

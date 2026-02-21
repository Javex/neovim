return {
  'pearofducks/ansible-vim',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  event = {
    'BufRead *.yaml,*.yml,*.j2',
    'BufNewFile *.yaml,*.yml,*.j2',
  },
}

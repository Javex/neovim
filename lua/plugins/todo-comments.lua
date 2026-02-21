-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}

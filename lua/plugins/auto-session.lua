return {
  'rmagatti/auto-session',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
  },
}

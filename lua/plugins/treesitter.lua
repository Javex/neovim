return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  opts = {
    indent = {
      disable = {
        'yaml',
      },
    },
    ensure_installed = {
      -- defaults
      'vim',
      'lua',

      -- Required by folke/noice.nvim
      'regex',
      'bash',
      'markdown',
      'markdown_inline',

      -- config file languages
      -- YAML is disabled for now because it's auto-indentation is a bit buggy
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5653
      -- "yaml",

      -- Programming languages
      'python',
      'go',
      'rust',
      'c',
      'typescript',

      -- HCL / Terraform
      'hcl',

      -- Markup
      'html',

      -- Bazel
      'starlark',

      -- Kubernetes
      'helm',
    },
  },
  config = function()
    local filetypes = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}

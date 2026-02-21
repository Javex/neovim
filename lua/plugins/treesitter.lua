return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- Disable in VSCode unless you know you need it and it works
  enabled = not vim.g.vscode,
  config = function()
    local filetypes = {
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
    }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}

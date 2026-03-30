return {
  {
    'mason-org/mason.nvim',
    -- Disable in VSCode unless you know you need it and it works
    enabled = not vim.g.vscode,
    -- Empty options are necessary as otherwise the setup function won't be
    -- called.
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Disable in VSCode unless you know you need it and it works
    enabled = not vim.g.vscode,
    opts = {
      ensure_installed = {
        -- Treesitter
        -- This is required for treesitter to compile languages
        -- NOTE: Not installed here via Mason because it doesn't work on e.g.
        -- Ubuntu 22.04. Instead, Neovim expects the CLI to be installed from
        -- the outside using the OS or Cargo manually.
        -- This should be managed in the ansible role:
        -- https://github.com/Javex/ansible-collection/tree/main/roles/neovim/tasks
        -- 'tree-sitter-cli',

        -- Lua
        'lua-language-server',
        'stylua',

        -- Ansible
        'ansible-language-server',
        -- Don't install ansible-lint using Mason, it should be available from a
        -- virtual environment before launching nvim. Otherwise the versions get
        -- out of sync and weird behaviour appears.
        -- "ansible-lint",

        -- Python
        'pyright',
        'debugpy',
        'ruff',

        -- Rust
        'rust-analyzer',
        'codelldb',

        -- Golang
        'gopls',

        -- HTML
        'djlint',

        -- C++
        'clangd',

        -- Terraform
        'terraform-ls',

        -- Kubernetes
        'helm-ls',

        -- Markdown
        'mdformat', -- Formatter

        -- TypeScript / JavaScript / NodeJS
        'typescript-language-server',
        'prettier', -- Formatter
      },
    },
    dependencies = { 'mason-org/mason.nvim' },
    lazy = false,
  },
}

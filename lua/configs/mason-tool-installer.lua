local options = {
  ensure_installed = {
    -- Lua
    "lua-language-server",

    -- Ansible
    "ansible-language-server",
    -- Don't install ansible-lint using Mason, it should be available from a
    -- virtual environment before launching nvim. Otherwise the versions get
    -- out of sync and weird behaviour appears.
    -- "ansible-lint",

    -- Python
    "pyright",
    "debugpy",
    "ruff",

    -- Rust
    "rust-analyzer",
    "codelldb",

    -- Golang
    "gopls",

    -- HTML
    "djlint",

    -- C++
    "clangd",

    -- Terraform
    "terraform-ls",

    -- Kubernetes
    "helm-ls",

    -- Markdown
    "mdformat", -- Formatter

    -- TypeScript / JavaScript / NodeJS
    "typescript-language-server",
    "prettier", -- Formatter
  },
}

return options

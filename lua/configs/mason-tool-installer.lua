local options = {
  ensure_installed = {
    -- Lua
    "lua-language-server",

    -- Ansible
    "ansible-language-server",
    "ansible-lint",

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

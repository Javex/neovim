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

    -- C#
    "omnisharp",

    -- HTML
    "djlint",

    -- C++
    "clangd",
  },
}

return options

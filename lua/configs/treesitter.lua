local options = {
  indent = {
    disable = {
      "yaml",
    },
  },
  ensure_installed = {
    -- defaults
    "vim",
    "lua",

    -- Required by folke/noice.nvim
    "regex",
    "bash",
    "markdown",
    "markdown_inline",

    -- config file languages
    -- YAML is disabled for now because it's auto-indentation is a bit buggy
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5653
    -- "yaml",

    -- Programming languages
    "python",
    "go",
    "rust",
    "c",

    -- HCL / Terraform
    "hcl",

    -- Markup
    "html",

    -- Bazel
    "starlark",

    -- Kubernetes
    "helm",
  },
}
return options

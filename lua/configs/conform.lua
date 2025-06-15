return {
  formatters_by_ft = {
    -- lua = { "stylua" },
    rust = { "rustfmt" },
    caddyfile = { "caddy" },
    go = { "gofmt" },
    html = { "djlint" },
    python = { "ruff_format" },
    tf = { "terraform_fmt" },
    markdown = { "mdformat" },
    ["terraform-vars"] = { "terraform_fmt" },
    typescript = { "prettier" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  formatters = {
    caddy = {
      command = "caddy",
      args = { "fmt", "-" },
      exit_codes = { 0, 1 },
    },
  },
}

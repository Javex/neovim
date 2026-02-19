return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fm',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat [m]y buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      caddyfile = { 'caddy' },
      go = { 'gofmt' },
      html = { 'djlint' },
      python = { 'ruff_format' },
      tf = { 'terraform_fmt' },
      markdown = { 'mdformat' },
      ['terraform-vars'] = { 'terraform_fmt' },
      typescript = { 'prettier' },
      yaml = { 'prettier' },
    },
    formatters = {
      caddy = {
        command = 'caddy',
        args = { 'fmt', '-' },
        exit_codes = { 0, 1 },
      },
    },
  },
}

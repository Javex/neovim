-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local capabilities = nvlsp.capabilities

-- Add LSP servers here if using default configuration, just a simple string,
-- e.g. "pyright". Use complete configuration if using separate settings.
local servers = {
  "gopls",
  "clangd",
  "terraformls",
  "helm_ls",
  "ts_ls", -- Typescript
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        ignored = {
          -- See: https://book.leptos.dev/getting_started/leptos_dx.html#2-editor-autocompletion-inside-component-and-server
          leptos_macro = {
            -- optional: --
            -- "component",
            "server",
          },
        },
      },
    },
  },
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('ansiblels', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
      },
    },
  },
})
vim.lsp.enable('ansiblels')

vim.lsp.config('pyright', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
})
vim.lsp.enable('pyright')

-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local capabilities = nvlsp.capabilities

local lspconfig = require "lspconfig"
-- Add LSP servers here if using default configuration, just a simple string,
-- e.g. "pyright". Use complete configuration if using separate settings.
local servers = {
  "gopls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
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
  }
}

lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
      },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      }
    }
  }
}

lspconfig.omnisharp.setup {
  cmd = { "dotnet", "/home/flozza/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },

}

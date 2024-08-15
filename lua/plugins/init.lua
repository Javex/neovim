local plugins = {
  -- Treesitter handles parsing & syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    -- Copied from nvchad/plugins/init.lua
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end

      telescope.load_extension "ui-select"
    end,
  },

  {
    -- A nicer UI for vim.ui calls
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    dependencies = { "folke/neoconf.nvim" },
  },
  {
    "williamboman/mason.nvim",
    opts = require "configs.mason",
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- lua = { "stylua" },
        rust = { "rustfmt" },
        caddyfile = { "caddy" },
        go = { "gofmt" },
        html = { "djlint" },
        python = { "ruff_format" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      formatters = {
        caddy = {
          command = "caddy",
          args = { "fmt", "-" },
          exit_codes = { 0, 1 },
        },
      },
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "tpope/vim-obsession",
    cmd = { "Obsession" },
    event = { "SessionLoadPost" },
  },
  {
    "pearofducks/ansible-vim",
    event = {
      "BufRead *.yaml,*.yml,*.j2",
      "BufNewFile *.yaml,*.yml,*.j2",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

  -- Debugger configuration
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Configure look of breakpoints in sign sidebar
      -- Needs a nerd font or similar
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    main = "dapui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  -- Python
  {
    "mfussenegger/nvim-dap-python",
    event = {
      "BufRead *.py",
      "BufNewFile *.py",
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-python").setup "/home/flozza/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      -- Try to parse a `.vscode/launch.json` if it exists
      local ftmap = {
        debugpy = { "python" },
      }
      require("dap.ext.vscode").load_launchjs(nil, ftmap)
    end,
  },

  -- Golang
  {
    "leoluz/nvim-dap-go",
    ft = { "go" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-go").setup()
    end,
  },

  -- Caddyfile
  { "nvim-neotest/nvim-nio" },
  {
    "isobit/vim-caddyfile",
    event = {
      "BufRead Caddyfile, *.Caddyfile",
      "BufNewFile Caddyfile, *.Caddyfile",
    },
  },

  -- Omnisharp extended
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    event = {
      "BufRead *.cs",
      "BufNewFile *.cs",
    },
  },

  -- neoconf
  {
    "folke/neoconf.nvim",
    cmd = {
      "Neoconf",
    },
    opts = {},
  },
}

return plugins

local function set_theme(name)
  local chadrc = require "chadrc"
  local cur_theme = chadrc.base46.theme
  require("nvchad.utils").replace_word('theme = "' .. cur_theme, 'theme = "' .. name)
  require('nvconfig').base46.theme = name
  require('base46').load_all_highlights()
end

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
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        set_theme('solarized_dark')
      end,
      set_light_mode = function()
        set_theme('solarized_light')
      end,
    },
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
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = require "configs.mason-tool-installer",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    opts = function()
      return require "configs.conform"
    end,
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
      "nvim-neotest/nvim-nio",
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
  {
    "isobit/vim-caddyfile",
    event = {
      "BufRead Caddyfile, *.Caddyfile",
      "BufNewFile Caddyfile, *.Caddyfile",
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

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },

  -- AI Coding assistant
  -- This plugin is deliberately only loaded with the :Copilot command. If it
  -- were to auto-load it would always send all code up to the cloud which
  -- isn't great. By enabling it explicitly, it only does that for the current
  -- workspace.
  {
    "github/copilot.vim",
    cmd = {
      "Copilot",
    },
  },
}

return plugins

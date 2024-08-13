require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Default mappings that were here before
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Redefine these here as well as NvChad configures them and it conflicts with
-- the tmux navigator plugin. Simply removing them doesn't work as then nothing
-- will handle then so there's a bit of duplication here.
map({ "i", "n" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
map({ "i", "n" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
map({ "i", "n" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
map({ "i", "n" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")

-- Telescope override: Follow links
map("n", "<leader>ff", "<cmd> Telescope find_files follow=true <CR>", { desc = "telescope find files" })

-- Clipboard
map({ "v", "n" }, "<leader>y", '"+y', { desc = "Clipboard Yank" })
map("n", "<leader>p", '"+p', { desc = "Clipboard Paste" })
map("n", "<leader>P", '"+P', { desc = "Clipboard Paste but line above" })

-- Tabufline
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer close ALL" })

-- LSP config
map("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "LSP Floating diagnostic" })
map("n", "<leader>lh", function()
  vim.lsp.buf.hover()
end, { desc = "LSP Hover Symbol Information" })
map("n", "<leader>li", function()
  vim.lsp.buf.implementation()
end, { desc = "LSP Implementation List" })
map("n", "<leader>lc", function()
  vim.lsp.buf.incoming_calls()
end, { desc = "LSP Call List" })
map("n", "<leader>lr", function()
  vim.lsp.buf.references()
end, { desc = "LSP Reference List" })

-- Debugger
map("n", "<F5>", function()
  require "dapui" -- Trigger lazy load
  require("dap").continue()
end, { desc = "Debug Run/Continue" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug Step Into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Debug Step Out ('End')" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug Toggle Breakpoint" })
map("n", "<leader>dx", function()
  require("dap").repl.open()
end, { desc = "Debug Open REPL" })
map("n", "<leader>dO", function()
  require("dapui").toggle()
end, { desc = "Debug Toggle DAP UI Explicitly" })

-- C# / Omnisharp
-- See https://github.com/Hoffs/omnisharp-extended-lsp.nvim
map("n", "gd", function()
  require("omnisharp_extended").lsp_definition()
end, { desc = "Omnisharp Go to definition" })
map("n", "<leader>D", function()
  require("omnisharp_extended").lsp_type_definition()
end, { desc = "Omnisharp Go to type definition" })
map("n", "gr", function()
  require("omnisharp_extended").lsp_references()
end, { desc = "Omnisharp Go to references" })
map("n", "gi", function()
  require("omnisharp_extended").lsp_implementation()
end, { desc = "Omnisharp Go to implementation" })

-- Remove key maps
-- Uncomment to use nomap function
-- local nomap = vim.keymap.del

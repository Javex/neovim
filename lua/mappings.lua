if not vim.g.vscode then
	require "nvchad.mappings"
end

-- add yours here

local map = vim.keymap.set

-- Default mappings that were here before
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Clipboard
map({ "v", "n" }, "<leader>y", '"+y', { desc = "Clipboard Yank" })
map("n", "<leader>p", '"+p', { desc = "Clipboard Paste" })
map("n", "<leader>P", '"+P', { desc = "Clipboard Paste but line above" })

if not vim.g.vscode then
	-- VSCode extension does not support insert mode key bindings because it's
	-- not controlled by Neovim
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

	-- Tabufline
	map("n", "<leader>X", function()
		require("nvchad.tabufline").closeAllBufs()
	end, { desc = "buffer close ALL" })
	-- Move between nvim tabs (small number in the top right).
	-- These "tabs" are more like "windows" and the tabufline above handles
	-- "buffers" and displays them more like tabs at the top.
	-- Switch between tabs
	map("n", "<leader><Tab>", function()
		vim.cmd ":tabNext"
	end, {
		desc = "Next Tab",
	})

	-- Copilot
	map("i", "<C-J>", "copilot#Accept('\\<CR>')", {
		expr = true,
		replace_keycodes = false,
		desc = "Copilot Accept",
	})
	map("i", "<C-O>", "<Plug>(copilot-accept-word)", {
		desc = "Copilot Accept Word",
	})
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

	-- Copilot
	map("i", "<C-J>", "copilot#Accept('\\<CR>')", {
		expr = true,
		replace_keycodes = false,
		desc = "Copilot Accept",
	})
	map("i", "<C-I>", "<Plug>(copilot-accept-word)", {
		desc = "Copilot Accept Word",
	})

	-- Remove key maps
	-- Uncomment to use nomap function
	-- local nomap = vim.keymap.del
else
	-- Emulate behaviour of closing a buffer
	map("n", "<leader>x", function()
		require("vscode").action("workbench.action.closeActiveEditor")
	end, { desc = "Close tab" })
	-- Emulate telescope find files
	map("n", "<leader>ff", function()
		require("vscode").action("workbench.action.quickOpen")
	end, { desc = "Open from workspace" })
	-- Emulate telescope find open buffers
	map("n", "<leader>fb", function()
		require("vscode").action("workbench.action.quickOpenPreviousRecentlyUsedEditor")
	end, { desc = "Find open file" })

	-- Navigate between open groups/splits
	map("n", "<C-L>", function()
		require("vscode").action("workbench.action.navigateRight")
	end, { desc = "Move to right split" })
	map("n", "<C-H>", function()
		require("vscode").action("workbench.action.navigateLeft")
	end, { desc = "Move to left split" })
	map("n", "<C-K>", function()
		require("vscode").action("workbench.action.navigateUp")
	end, { desc = "Move to upper split" })
	map("n", "<C-J>", function()
		require("vscode").action("workbench.action.navigateDown")
	end, { desc = "Move to lower split" })
end

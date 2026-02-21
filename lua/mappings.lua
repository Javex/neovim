-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- [[ Universal Shortcuts ]]
-- These shortcuts work both in proper Neovim and within VSCode

-- Clipboard
vim.keymap.set({ 'v', 'n' }, '<leader>y', '"+y', { desc = 'Clipboard Yank' })
vim.keymap.set({ 'v', 'n' }, '<leader>d', '"+d', { desc = 'Clipboard Cut' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Clipboard Paste' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Clipboard Paste but line above' })

-- [[ Neovim Shortcuts ]]
-- These shortcuts only work in a proper Neovim instance, not in VSCode
if not vim.g.vscode then
  -- TODO: Look into nvchad mappings I want to keep
  -- require 'nvchad.mappings'

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
  vim.keymap.set('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

  -- Close buffers
  vim.keymap.set('n', '<leader>x', function()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.pai.nvim_buf_delete(current_buf, { force = false })
  end, { desc = 'Close current buffer' })
  vim.keymap.set('n', '<leader>X', function()
    local current_buf = vim.api.nvim_get_current_buf()
    local listed_buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(listed_buffers) do
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end, { desc = 'Close all buffers' })

  -- Tab movement
  -- Neovim "tabs" are more like "windows" (or "layouts").
  vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<CR>', {
    desc = 'Next Tab',
  })
  vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabprevious<CR>', {
    desc = 'Previous Tab',
  })

  -- Copilot
  -- Commented out to keep the example of how to configure Copilot bindings
  -- vim.keymap.set('i', '<C-J>', "copilot#Accept('\\<CR>')", {
  --   expr = true,
  --   replace_keycodes = false,
  --   desc = 'Copilot Accept',
  -- })
  -- vim.keymap.set('i', '<C-O>', '<Plug>(copilot-accept-word)', {
  --   desc = 'Copilot Accept Word',
  -- })
else
  -- [[ VSCode Shortcuts ]]
  -- These shortcuts only apply in VSCode
  -- Emulate behaviour of closing a buffer
  vim.keymap.set('n', '<leader>x', function() require('vscode').action 'workbench.action.closeActiveEditor' end, { desc = 'Close tab' })
  -- Emulate telescope find files
  vim.keymap.set('n', '<leader>ff', function() require('vscode').action 'workbench.action.quickOpen' end, { desc = 'Open from workspace' })
  -- Emulate telescope find open buffers
  vim.keymap.set('n', '<leader>fb', function() require('vscode').action 'workbench.action.quickOpenPreviousRecentlyUsedEditor' end, { desc = 'Find open file' })

  -- Navigate between open groups/splits
  vim.keymap.set('n', '<C-L>', function() require('vscode').action 'workbench.action.navigateRight' end, { desc = 'Move to right split' })
  vim.keymap.set('n', '<C-H>', function() require('vscode').action 'workbench.action.navigateLeft' end, { desc = 'Move to left split' })
  vim.keymap.set('n', '<C-K>', function() require('vscode').action 'workbench.action.navigateUp' end, { desc = 'Move to upper split' })
  vim.keymap.set('n', '<C-J>', function() require('vscode').action 'workbench.action.navigateDown' end, { desc = 'Move to lower split' })
end

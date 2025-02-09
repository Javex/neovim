require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Disable clipboard option
-- NvChad sets this to "unnamedplus" but that means all yank and delete end up
-- in the clipboard. The key map below avoids that by using clipboard
-- explicitly via the <leader> key
vim.opt.clipboard = ""

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Configure a line at 80 characters and set text width to 79 which auto-wraps
-- after that line length.
vim.cmd [[set colorcolumn=+1]]
vim.cmd [[set textwidth=79]]

-- Configure folding
vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
-- Disable folding at startup
vim.cmd [[set nofoldenable]]

-- Set custom file types
vim.filetype.add {
  extension = {
    Caddyfile = "caddyfile",
    tera = "html",
  },
  filename = {
    [".djlintrc"] = "json",
  },
}

-- Spellchecking
vim.opt.spelllang = "en_gb"
vim.opt.spell = true

-- Import vimscript
local current_file = debug.getinfo(1, "S").source:sub(2) -- Get the current file's path
local current_dir = vim.fn.fnamemodify(current_file, ":h") -- Get the directory
vim.cmd("source " .. current_dir .. "/vimscript/helm.vim")

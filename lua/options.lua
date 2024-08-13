require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Disable clipboard option
-- NvChad sets this to "unnamedplus" but that means all yank and delete end up
-- in the clipboard. The key map below avoids that by using clipboard
-- explicitly via the <leader> key
vim.opt.clipboard = ""

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

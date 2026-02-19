-- views can only be fully collapsed with the global statusline
vim.o.laststatus = 3

-- Configure a line at 80 characters and set text width to 79 which auto-wraps
-- after that line length.
vim.o.colorcolumn = '+1'
vim.o.textwidth = 79

-- Configure folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Disable folding at startup
vim.o.foldenable = false

-- Set custom file types
vim.filetype.add {
  extension = {
    Caddyfile = 'caddyfile',
    tera = 'html',
    tf = 'terraform',
  },
  filename = {
    ['.djlintrc'] = 'json',
    -- Renovate treats these files as JSONC (JSON with Comments). By setting
    -- this file type explicitly it allows editing the file with neovim and
    -- getting correct syntax highlighting even if there's comments.
    ['renovate.json'] = 'jsonc',
  },
}

-- Spellchecking
vim.o.spelllang = 'en_gb'
vim.o.spell = true

-- Import vimscript
local current_file = debug.getinfo(1, 'S').source:sub(2) -- Get the current file's path
local current_dir = vim.fn.fnamemodify(current_file, ':h') -- Get the directory
vim.cmd('source ' .. current_dir .. '/vimscript/helm.vim')

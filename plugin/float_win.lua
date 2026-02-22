-- Floating terminal
-- Create a singleton terminal that opens in a floating window. Allows running quick commands as well as background processes.
-- Source: https://www.youtube.com/watch?v=5PIiKDES_wc

-- Track window & buffer state. Used to restore an existing terminal if there already is one.
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

--- Open a centred floating window with 10% margins and rounded borders.
--- @param opts table|nil Optional overrides: width, height, buf, enter, title.
--- @return { buf: number, win: number }|nil float_ids table with buffer & window IDs belonging to the floating window. Returns nil on error.
local function open_floating_window(opts)
  opts = vim.tbl_extend('force', {
    width = nil,
    height = nil,
    buf = nil,
    enter = true,
    title = nil,
  }, opts or {})

  local columns = vim.o.columns
  local lines = vim.o.lines

  -- 10% margin each side => use 80% of space
  local width = opts.width or math.floor(columns * 0.8)
  local height = opts.height or math.floor(lines * 0.8)

  -- Centre the window
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  if not buf or not vim.api.nvim_buf_is_valid(buf) then return nil end

  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = opts.title,
    title_pos = opts.title and 'center' or nil,
  }

  local win = vim.api.nvim_open_win(buf, opts.enter, win_opts)
  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    local floating = open_floating_window { buf = state.floating.buf }
    if floating == nil then
      vim.notify('Failed to open floating terminal (buffer or window creation failed)', vim.log.levels.ERROR)
      return
    end
    state.floating = floating

    if vim.bo[state.floating.buf].buftype ~= 'terminal' then vim.cmd.terminal() end
    -- Automatically enter insert (terminal) mode when the terminal is shown
    -- Allows starting to type commands right away
    vim.api.nvim_set_current_win(state.floating.win)
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('FloatingTerminal', toggle_terminal, { desc = 'Create floating terminal ' })
-- NOTE: This is currently set to only work in normal mode. If the mode is also 't' then typing <leader>tt quickly will close the terminal instead of typing those letters in the terminal.
vim.keymap.set('n', '<leader>tt', toggle_terminal, { desc = '[t]oggle floating [t]erminal' })

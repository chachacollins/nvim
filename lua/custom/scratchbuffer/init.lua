local M = {}

M.expand_path = function(path)
  if path:sub(1, 1) == '~' then
    return os.getenv 'HOME' .. path:sub(2)
  end
  return path
end

local function center_in(outer, inner)
  return (outer - inner) / 2
end

local function win_config()
  local width = math.min(math.floor(vim.o.columns * 0.8), 64)
  local height = math.floor(vim.o.lines * 0.8)
  return {
    title = 'Scratch',
    title_pos = 'center',
    relative = 'editor',
    width = width,
    height = height,
    col = center_in(vim.o.columns, width),
    row = center_in(vim.o.lines, height),
    border = 'single',
  }
end

local function open_floating_buf(path)
  local expanded_path = M.expand_path(path)
  if vim.fn.filereadable(expanded_path) == 0 then
    vim.notify('file does not exist at directory:' .. expanded_path, vim.log.levels.ERROR)
    return
  end
  local buf = vim.fn.bufnr(expanded_path, true)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, expanded_path)
  end
  vim.bo[buf].swapfile = false
  vim.api.nvim_open_win(buf, true, win_config())
end

local function load_file()
  local date = os.date '*t'
  local day = string.format('%s', date.day)
  local month = string.format('%s', date.month)
  local year = string.format('%s', date.year)
  local interim = day .. '-' .. month .. '-' .. year .. '.md'
  local file_path = M.expand_path '~/Documents/todo/' .. interim
  local file = io.open(file_path, 'rb')
  if file ~= nil then
    file:close()
    return file_path
  else
    file = io.open(file_path, 'w') or error 'Could not create file'
    file:write '# TODO'
    file:close()
    return file_path
  end
end

local function setup_user_cmds(opts)
  local target_file = load_file()
  vim.api.nvim_create_user_command('Td', function()
    open_floating_buf(target_file)
  end, opts)
end

M.setup = function(opts)
  setup_user_cmds(opts)
end
return M

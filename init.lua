-- [[ OPTIONS ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.cmp_enabled = false
vim.opt.number = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.relativenumber = true
vim.opt.mouse = 'v'
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.showmode = true
vim.opt.laststatus = 0
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.signcolumn = 'no'
vim.opt.updatetime = 250
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.o.guicursor = 'n-v-c:block,i-ci-ve:bloc,r-cr-o:bloc'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.o.swapfile = false

-- [[ KEYBINDS ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Do something amazing' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Wow this really is awesome' })
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('i', '<C-a>', '<C-o>_')
vim.keymap.set('i', '<C-k>', '<C-o>D')
vim.api.nvim_set_keymap('v', 'J', ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open file explorer' })

-- [[ PLUGINS ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup {
  'tpope/vim-sleuth',
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { import = 'plugins' },
}

-- [[ Random stuff]]
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.h',
  callback = function()
    vim.bo.filetype = 'c'
  end,
})

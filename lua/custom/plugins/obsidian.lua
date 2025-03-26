return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {
      workspaces = {
        {
          name = 'personal',
          path = vim.fn.expand '~/Documents/chacha/',
        },
      },
      disable_frontmatter = true,

      -- Additional configuration to ensure loading
      ui = { enable = false },
    }
  end,
}

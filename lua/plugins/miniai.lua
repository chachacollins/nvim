return {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S](rround) [R]eplace [)] [']
      require('mini.surround').setup {
        custom_surroundings = {
          ['('] = { output = { left = '(', right = ')' } },
          [')'] = { output = { left = '( ', right = ' )' } },

          ['['] = { output = { left = '[', right = ']' } },
          [']'] = { output = { left = '[ ', right = ' ]' } },

          ['{'] = { output = { left = '{', right = '}' } },
          ['}'] = { output = { left = '{ ', right = ' }' } },
        },
        mappings = {
          add = 's', -- Use 's' normally for adding surroundings
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',

          -- Disable specific default actions by setting to false
        },
      }
      -- require('mini.icons').setup()

      -- Optional: Add a keymapping to toggle mini.files
      -- vim.keymap.set('n', '<leader>e', '<CMD>lua MiniFiles.open()<CR>', { desc = 'Open file explorer' })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

    end,
}

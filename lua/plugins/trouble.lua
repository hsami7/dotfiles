return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
  opts = {
    focus = true,
  },
  cmd = 'Trouble',
  keys = {
    -- Use these to see errors in your C/PHP projects
    { '<leader>dx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Project Diagnostics (Trouble)' },
    { '<leader>db', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>dq', '<cmd>Trouble quickfix toggle<CR>', desc = 'Quickfix List (Trouble)' },
    { '<leader>dl', '<cmd>Trouble loclist toggle<CR>', desc = 'Location List (Trouble)' },
    { '<leader>dt', '<cmd>Trouble todo toggle<CR>', desc = 'Open Todos in Trouble' },
  },
}

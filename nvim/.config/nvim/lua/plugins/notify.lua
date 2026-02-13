return {
  'rcarriga/nvim-notify',
  opts = {
    -- The "minimal" render style matches your screenshot's clean look
    render = 'minimal',

    -- "fade" or "static" stages look best with the minimal style
    stages = 'fade',

    -- Set a shorter timeout for a cleaner workflow
    timeout = 3000,

    -- This ensures it doesn't span the whole screen width
    max_width = 50,

    -- Optional: Typecraft often uses these icons
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '✎',
    },
  },
  init = function()
    vim.notify = require 'notify'
  end,
}

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require 'nvim-autopairs'

    autopairs.setup {
      check_ts = true, -- Enable Treesitter integration
      ts_config = {
        lua = { 'string' }, -- Don't add pairs in lua string nodes
        javascript = { 'template_string' }, -- Don't add pairs in JS template strings
      },
    }

    -- If you want it to work with your completion menu (nvim-cmp)
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}

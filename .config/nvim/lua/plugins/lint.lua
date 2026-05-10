return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      python = { 'ruff' },
      bash = { 'shellcheck' },
      make = { 'checkmake' },
      php = { 'phpstan' },
    }

    local augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

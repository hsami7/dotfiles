return {
  'nvim-telescope/telescope.nvim',
  branch = 'master', -- Keep as master to fix ft_to_lang error
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'nvim-treesitter/nvim-treesitter', -- Explicitly add treesitter dependency for Telescope
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin' -- For help_tags, keymaps, diagnostics

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        hidden = true, -- Re-add hidden = true
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-t>'] = actions.send_to_qflist,
          },
        },
      },
    }

    telescope.load_extension 'fzf'

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
    -- Previously established keymaps:
    keymap.set('n', '<leader>hh', builtin.help_tags, { desc = '[H]elp [H]eaders' }) -- from previous
    keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search keymaps' }) -- from previous
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' }) -- from previous
    keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'Go to Symbol (Function/Variable)' })
  end,
}

return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'

    -- Check if trouble is installed before requiring it
    local has_trouble, trouble_telescope = pcall(require, 'trouble.sources.telescope')

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        hidden = true,
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            -- Push Telescope results to the Trouble panel for easier navigation
            ['<C-t>'] = has_trouble and trouble_telescope.open or nil,
          },
        },
      },
    }

    telescope.load_extension 'fzf'
    telescope.load_extension 'file_browser'

    local keymap = vim.keymap

    -- Standard Search
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    keymap.set('n', '<leader>fl', require('telescope').extensions.file_browser.file_browser, { desc = 'Find Folders' })
    keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find Text (Grep)' })
    keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
    keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find Word under Cursor' })

    -- Buffer & Code Structure (The ones you requested)
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Search Open Buffers' })
    keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'Find Symbols (Functions/Vars)' })

    -- LSP & Diagnostics
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Search Diagnostics' })
    keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search Keymaps' })
    keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Search Help' })
  end,
}

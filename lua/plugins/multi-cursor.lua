return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    -- This prevents the plugin from using default keys that might conflict
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ['Find Under'] = '<C-n>', -- Ctrl+n selects the word like in VS Code
    }
  end,
}

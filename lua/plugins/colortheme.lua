return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local bg = '#011628'
      local bg_dark = '#011423'
      local bg_highlight = '#143652'
      local bg_search = '#0A64AC'
      local bg_visual = '#275378'
      local fg = '#CBE0F0'
      local fg_dark = '#B4D0E9'
      local fg_gutter = '#627E97'
      local border = '#547998'

      -- We use a local variable to track transparency state
      local transparent_enabled = true

      local function get_opts()
        return {
          style = 'night',
          transparent = transparent_enabled,
          styles = {
            sidebars = transparent_enabled and 'transparent' or 'dark',
            floats = transparent_enabled and 'transparent' or 'dark',
          },
          on_colors = function(colors)
            -- Only apply hardcoded dark colors if NOT transparent
            if not transparent_enabled then
              colors.bg = bg
              colors.bg_dark = bg_dark
              colors.bg_float = bg_dark
              colors.bg_popup = bg_dark
              colors.bg_sidebar = bg_dark
              colors.bg_statusline = bg_dark
            end
            colors.bg_highlight = bg_highlight
            colors.bg_search = bg_search
            colors.bg_visual = bg_visual
            colors.border = border
            colors.fg = fg
            colors.fg_dark = fg_dark
            colors.fg_float = fg
            colors.fg_gutter = fg_gutter
            colors.fg_sidebar = fg_dark
          end,
          on_highlights = function(hl, c)
            hl.GitSignsAdd = { fg = c.green, bg = 'NONE' }
            hl.GitSignsChange = { fg = c.orange, bg = 'NONE' }
            hl.GitSignsDelete = { fg = c.red, bg = 'NONE' }
            hl.NvimTreeGitDirty = { fg = c.orange }
            hl.NvimTreeGitStaged = { fg = c.green }
            hl.NvimTreeGitNew = { fg = c.green }
            hl.NvimTreeGitDeleted = { fg = c.red }
            hl.TelescopeBorder = { fg = border }
            hl.TelescopePromptBorder = { fg = border }
          end,
        }
      end

      -- Initial setup
      require('tokyonight').setup(get_opts())
      vim.cmd [[colorscheme tokyonight]]

      -- Simplified Toggle function
      local toggle_transparency = function()
        transparent_enabled = not transparent_enabled
        require('tokyonight').setup(get_opts())
        vim.cmd [[colorscheme tokyonight]]
      end

      vim.keymap.set('n', '<leader>bg', toggle_transparency, {
        noremap = true,
        silent = true,
        desc = 'Toggle Transparency',
      })
    end,
  },
}

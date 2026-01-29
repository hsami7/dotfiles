return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      local opts = {}

      opts = {
        style = "night",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          if not opts.transparent then
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
      }
      require("tokyonight").setup(opts)
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])

      -- Toggle background transparency
      local toggle_transparency = function()
        opts.transparent = not opts.transparent
        require("tokyonight").setup(opts)
        vim.cmd [[colorscheme tokyonight]]
      end

      vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true, desc = "Toggle Transparency" })
    end,
  },
}

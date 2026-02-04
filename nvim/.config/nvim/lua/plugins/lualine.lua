return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    local function get_lsp_status_component()
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
      local buf_ft = vim.bo.filetype
      local lsp_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "copilot" and client.name ~= "null-ls" then
          table.insert(lsp_client_names, " " .. client.name)
        end
      end

      -- Add sources (from null-ls)
      local null_ls_s, null_ls = pcall(require, "null-ls")
      if null_ls_s then
        local sources = null_ls.get_sources()
        for _, source in ipairs(sources) do
          if source._validated then
            for ft_name, ft_active in pairs(source.filetypes) do
              if ft_name == buf_ft and ft_active then
                table.insert(lsp_client_names, " " .. source.name)
              end
            end
          end
        end
      end

      -- Add formatters (from formatter.nvim) - these are also LSP-related in context
      local formatter_s, _ = pcall(require, "formatter")
      if formatter_s then
        local formatter_util = require("formatter.util")
        for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
          if formatter then
            table.insert(lsp_client_names, " " .. formatter)
          end
        end
      end

      local unique_lsp_client_names = {}
      for _, client_name_target in ipairs(lsp_client_names) do
        local is_duplicate = false
        for _, client_name_compare in ipairs(unique_lsp_client_names) do
          if client_name_target == client_name_compare then
            is_duplicate = true
          end
        end
        if not is_duplicate then
          table.insert(unique_lsp_client_names, client_name_target)
        end
      end

      if #unique_lsp_client_names == 0 then
        return ""
      end

      return table.concat(unique_lsp_client_names, ", ")
    end

    local function get_lint_status_component()
      local buf_ft = vim.bo.filetype
      local lint_names = {}

      -- Add linters (from nvim-lint)
      local lint_s, lint = pcall(require, "lint")
      if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
          if type(ft_v) == "table" then
            for _, linter in ipairs(ft_v) do
              if buf_ft == ft_k then
                table.insert(lint_names, "󰩡 " .. linter)
              end
            end
          elseif type(ft_v) == "string" then
            if buf_ft == ft_k then
              table.insert(lint_names, "󰩡 " .. ft_v)
            end
          end
        end
      end

      local unique_lint_names = {}
      for _, lint_name_target in ipairs(lint_names) do
        local is_duplicate = false
        for _, lint_name_compare in ipairs(unique_lint_names) do
          if lint_name_target == lint_name_compare then
            is_duplicate = true
          end
        end
        if not is_duplicate then
          table.insert(unique_lint_names, lint_name_target)
        end
      end

      if #unique_lint_names == 0 then
        return ""
      end

      return table.concat(unique_lint_names, ", ")
    end


    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_c = {
          {
            function()
              -- Check if 'conform' is available
              local status, conform = pcall(require, 'conform')
              if not status then
                return 'Conform not installed'
              end

              local lsp_format = require('conform.lsp_format')

              -- Get formatters for the current buffer
              local formatters = conform.list_formatters_for_buffer()
              if formatters and #formatters > 0 then
                local formatterNames = {}

                for _, formatter in ipairs(formatters) do
                  table.insert(formatterNames, formatter)
                end

                return '󰷈 ' .. table.concat(formatterNames, ' ')
              end

              -- Check if there's an LSP formatter
              local bufnr = vim.api.nvim_get_current_buf()
              local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

              if not vim.tbl_isempty(lsp_clients) then
                return '󰷈 LSP Formatter'
              end

              return ''
            end,
            color = { gui = "bold" }
          },
          " ", -- Spacer
          {
            get_lsp_status_component,
            color = { gui = "bold" }
          },
          " ", -- Spacer
          {
            get_lint_status_component,
            color = { gui = "bold" }
          },
        },
        lualine_x = {
          "diagnostics",
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })  end,
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup({
          ensure_installed = {
            'prettier',
            'black',
            'stylua',
            'ruff',
            'shellcheck',
            'checkmake',
          },
        })
      end,
    },
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- ... (keep your existing autocmd logic here)

    local servers = {
      clangd = {}, -- CRITICAL for your C/Systems Programming
      bashls = {}, -- For your shell scripts/automation
      pyright = {}, -- High-performance Python LSP
      intelephense = {}, -- For your grade management PHP project
      sqlls = {},
      html = {},
      cmakels = {},
      tsserver = {},
      jsonls = {},
      yamlls = {},
      taplo = {},
      cssls = {},
      volar = {},
      powershell_es = {},
      gopls = {},
      solargraph = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            completion = { callSnippet = 'Replace' },
          },
        },
      },
    }

    -- Standard Kickstart capabilities broadcast
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Setup servers
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

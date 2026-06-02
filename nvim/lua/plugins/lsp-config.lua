-- File: lua/plugins/mason-lsp.lua
return {
  -- Mason package manager
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- For LSP capabilities
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
      local icons = require 'plugins.icons'
      local lspconfig = require 'lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup()

      -- require('mason-lspconfig').setup {
      --   automatic_installation = true,
      --   ensure_installed = {
      --     'texlab',
      --   },
      -- }

      -- Configure each LSP server (excluding jdtls which will be handled by nvim-java)
      local servers = {
        'lua_ls',
        'ts_ls',
        'cssls',
        'css',
        'sqlls',
        'pylsp',
        'html_ls',
        'clangd',
        'dockerls',
        'emmet_language_server',
        'jsonls',
        'texlab',
      }

      require('mason-tool-installer').setup {
        -- Install these linters, formatters, debuggers automatically
        ensure_installed = {
          servers,
        },
      }

      -- Common LSP setup function
      local function setup_lsp(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end

      -- Setup each server
      for _, server in ipairs(servers) do
        setup_lsp(server)
      end

      require('lspconfig').jdtls.setup {}

      require('lspconfig').texlab.setup {
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
              onSave = true,
            },
            chktex = {
              onEdit = true,
              onOpenAndSave = true,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = { modifyLineBreaks = true },
          },
        },
        on_attach = function(client, bufnr)
          local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
          end
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        end,
      }

      vim.lsp.enable(servers)
      -- Configure diagnostics
      local default_diagnostic_config = {
        signs = {
          active = true,
          values = {
            { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
            { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
            { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
            { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
          },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      }

      vim.diagnostic.config(default_diagnostic_config)

      for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      -- Keymappings
      vim.keymap.set('n', 'gK', vim.lsp.buf.hover, { desc = '[C]ode [H]over Documentation' })
      -- vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = '[C]ode Goto [D]efinition' })
      -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ctions' })
      -- vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })
      -- vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, { desc = '[C]ode Goto [D]eclaration' })

      -- If you have telescope, you can uncomment these
      -- vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
      -- vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
    end,
  },

  -- LSP Signature for function signatures
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  },
}

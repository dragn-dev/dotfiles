return {
	--   {
	--     'nvimtools/none-ls.nvim',
	--     dependencies = {
	--       'nvimtools/none-ls-extras.nvim',
	--       'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
	--     'stevearc/conform.nvim',
	--     },
	--     config = function()
	--       local null_ls = require 'null-ls'
	--       local formatting = null_ls.builtins.formatting -- to setup formatters
	--       local diagnostics = null_ls.builtins.diagnostics -- to setup linters
	--
	--       -- Formatters & linters for mason to install
	--       require('mason-null-ls').setup {
	--         ensure_installed = {
	--           'prettier', -- ts/js formatter
	--           'stylua', -- lua formatter
	--           'eslint_d', -- ts/js linter
	--           'shfmt', -- Shell formatter
	--           'checkmake', -- linter for Makefiles
	--           'ruff', -- Python linter and formatter
	--           'clang_format',
	--           -- 'biome',
	--         },
	--         automatic_installation = true,
	--       }
	--
	-- -- Configure conform
	--       require('conform').setup({
	--         format_on_save = {
	--           timeout_ms = 500,
	--           lsp_fallback = true,
	--         },
	--         formatters_by_ft = {
	--           lua = { 'stylua' },
	--           html = { 'prettier' },
	--           markdown = { 'prettier' },
	--           javascript = { 'prettier' },
	--           javascriptreact = { 'prettier' },
	--           typescript = { 'prettier' },
	--           typescriptreact = { 'prettier' },
	--           json = { 'prettier' },
	--           yaml = { 'prettier' },
	--           c = { 'clang_format' },
	--           cpp = { 'clang_format' },
	--           sql = { 'sql_formatter' },
	--         },
	--       })
	--
	--
	--
	--       local sources = {
	--         diagnostics.checkmake,
	--         -- diagnostics.eslint_d,
	--         pcall(require, "eslint_d") and diagnostics.eslint_d or nil,
	--
	--         -- formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } },
	--         -- formatting.stylua,
	--         -- formatting.shfmt.with { args = { '-i', '4' } },
	--         -- formatting.terraform_fmt,
	--         -- require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
	--         -- require 'none-ls.formatting.ruff_format',
	--         -- conform_format,  -- add conform as a source
	--
	--       }
	--
	--       -- Filter out nil values from sources
	--       sources = vim.tbl_filter(function(source)
	--         return source ~= nil
	--       end, sources)
	--
	--       local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
	--       null_ls.setup {
	--         debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
	--         sources = sources,
	--         -- you can reuse a shared lspconfig on_attach callback here
	--         on_attach = function(client, bufnr)
	--           -- Format on save
	--           if client.supports_method 'textDocument/formatting' then
	--             vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
	--             vim.api.nvim_create_autocmd('BufWritePre', {
	--               group = augroup,
	--               buffer = bufnr,
	--               callback = function()
	--                 vim.cmd('mkview')
	--                 vim.cmd('silent! loadview')
	--               end,
	--             })
	--           end
	--         end,
	--       }
	--     end,
	--   },
	--
	{ -- Autoformat
		"stevearc/conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 2500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { 'ruff' },
				-- html = { 'prettier' },
				markdown = { "prettier" },
				javascript = { "prettier", "biome" },
				typescript = { "prettier", "biome" },
				javascriptreact = { "prettier", "biome" },
				typescriptreact = { "prettier", "biome" },
				tex = { "latexindent" },
				c = { "clang_format" },
				rust = { "rust_fmt", lsp_format = "fallback" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { 'prettierd', 'prettier', stop_after_first = true },
			},
			-- formatters={
			--
			-- }
		},
		-- config = function()
		--   require('mason').setup()
		--   require('mason-conform').setup {
		--     ensure_installed = { 'stylua', 'prettier', 'latexindent', 'biome', 'clang_format' }, -- your formatters
		--   }
		-- end,
	},
}

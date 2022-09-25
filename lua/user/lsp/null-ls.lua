local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		-- formatting.rustfmt,
		
		-- formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    -- diagnostics.flake8
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
		  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
		  vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup_format,
			buffer = 0,
			callback = function() vim.lsp.buf.formatting_seq_sync() end
		  })
		end
	  end,
})
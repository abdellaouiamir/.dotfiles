-- on_init
local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end
-- apply this configuration to all lsp servers
vim.lsp.config('*', {
  on_init = on_init,
})
-- Mason PATH is handled by core.mason-path
vim.lsp.enable({
  "lua_ls",
  "gopls",
  "ts_ls",
  "pylsp",
  "clangd",
})

-- Config the error message
local severity = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = true, -- show errors inline
  -- virtual_lines = true, -- show errors in new virtual line
  update_in_insert = false,
  underline = true, -- Underline errors
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  --signs = true, -- show signs in the gutter
  signs = {
    text = {
      [severity.ERROR] = " 󰅚",
      [severity.WARN] = " 󰀪",
      [severity.INFO] = " 󰋽",
      [severity.HINT] = " 󰌶",
    }
  }
})

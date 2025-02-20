return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua, -- install stylua with mason
        -- null_ls.builtins.formatting.eslint, -- install eslint with mason
        -- null_ls.builtins.formatting.prettier, -- install prettier with mason
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          -- Clear existing autocmds to avoid duplicates
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })

          -- Format on save
          --[=[
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
          ]=]

          -- Add a keybinding to format the current buffer
          vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end, { desc = "Format current buffer", buffer = bufnr })
        end
      end,
    })
  end,
}

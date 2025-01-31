return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = { "lua_ls", "ts_ls", "gopls" },
      automatic_installation = false,
    }
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- auto completions
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }
      -- on_init
      local on_init = function(client, _)
        if client.supports_method "textDocument/semanticTokens" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end
      -- on_attach_buffer
      local on_attach = function(_, bufnr)
        local function opts(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
        vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts "List workspace folders")
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts "Show references")
      end
      -- Add lsp server
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            }
          }
        }
      })
    end
  }
}

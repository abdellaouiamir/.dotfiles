return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua_ls", -- lua language server
        "ts_ls", -- ts/js language server
        "gopls", -- go language server
        "pylsp", -- python language server
        "clangd", -- C/C++ language server
      },
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    lazy = false,
    config = function()
      -- capabilities
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- on_init
      local on_init = function(client, _)
        if client.supports_method("textDocument/semanticTokens") then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end
      -- on_attach_buffer
      local on_attach = function(_, bufnr)
        local function opts(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
        vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts("List workspace folders"))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
      end
      -- Add lsp server
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT)
              version = 'LuaJIT',
              -- Setup your lua path
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
          },
        },
      })
      lspconfig.ts_ls.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
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
            },
          },
        },
      })
      lspconfig.pylsp.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}

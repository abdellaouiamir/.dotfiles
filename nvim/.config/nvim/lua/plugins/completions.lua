return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-nvim-lsp", -- source for snippets from the lsp
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets"
        }
      },
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert({
          -- ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          -- ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select=true })
        }),
        -- sources for autocomplition
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "path" }, -- file system paths
          { name = "buffer" }, -- text within current buffer
        },
        {
          { name = "buffer" },
        })
      })
    end
  }
}

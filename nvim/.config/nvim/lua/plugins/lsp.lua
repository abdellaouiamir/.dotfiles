return {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
          require("mason").setup()
        end,
      },
      {
        "neovim/nvim-lspconfig",
        lazy = false,
      },
    },
    opts = {
      ensure_installed = {
        "lua_ls", -- lua language server
        "ts_ls", -- ts/js language server
        "gopls", -- go language server
        "pylsp", -- python language server
        "clangd", -- C/C++ language server
      },
      automatic_installation = false,
    }
  }
}

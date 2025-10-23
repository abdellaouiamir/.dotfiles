return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        modules = {},
        sync_install = false,
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          "lua",
        },
        highlight = { enable = true },
        indent = { enable = false },
      })
    end
  }
}

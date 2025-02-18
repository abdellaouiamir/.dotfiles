return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua, -- install stylua with mason
        -- null_ls.builtins.formatting.eslint, -- install stylua with mason
        null_ls.builtins.formatting.prettier, -- install stylua with mason
      },
    })
  end,
}

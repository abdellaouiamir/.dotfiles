return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        highlight_overrides = {
          all = function ()
            return {
              -- LineNr = { fg = "#fab387" },
              -- CursorLineNr = { fg = "#f9e2af", bold=true },
            }
          end
        }
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}

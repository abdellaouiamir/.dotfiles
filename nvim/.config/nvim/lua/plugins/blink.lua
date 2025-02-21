return {
  'saghen/blink.cmp',
  version = '*',
  dependencies ={
    'rafamadriz/friendly-snippets',
  },
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      menu = { border = 'single', },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'single',},
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = {
      enabled = true,
      window = { border = 'single', },
    },
  },
}

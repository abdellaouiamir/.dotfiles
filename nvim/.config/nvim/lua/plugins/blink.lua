return {
  'saghen/blink.cmp',
  version = '*',
  dependencies ={
    'rafamadriz/friendly-snippets',
    -- 'giuxtaposition/blink-cmp-copilot',
  },
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
        Class = ' ',
        Color = ' ',
        Constant = ' ',
        Constructor = '󰈏 ',
        Copilot = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Event = ' ',
        Field = ' ',
        File = ' ',
        Folder = ' ',
        Function = '󰊕 ',
        Interface = ' ',
        Keyword = ' ',
        Method = ' ',
        Module = '',
        Operator = ' ',
        Property = ' ',
        Reference = ' ',
        Snippet = ' ',
        Struct = ' ',
        Text = ' ',
        TypeParameter = ' ',
        Unit = ' ',
        Value = ' ',
        Variable = ' ',
      },
    },
    completion = {
      list = {
        selection = {
          auto_insert = true,
          preselect = true,
        }
      },
      menu = { border = 'rounded' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'rounded',},
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      --[[
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 90,
          async = true,
        },
      },
      ]]
    },
    signature = {
      enabled = true,
      window = { border = 'rounded', },
    },
  },
}

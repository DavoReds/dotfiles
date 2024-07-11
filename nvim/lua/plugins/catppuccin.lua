return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      default_integrations = false,
      flavour = "mocha",
      term_colors = true,
      transparent_background = true,
      integrations = {
        barbar = true,
        fidget = true,
        gitsigns = true,
        hop = true,
        indent_blankline = {
          enabled = true,
          scope_color = "peach",
          colored_indent_levels = false,
        },
        markdown = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "peach",
        },
        cmp = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        treesitter_context = true,
        treesitter = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        lsp_trouble = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}

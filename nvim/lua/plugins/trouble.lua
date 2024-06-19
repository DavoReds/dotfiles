return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>xx",
      "<CMD>Trouble diagnostics toggle focus=true<CR>",
      desc = "Toggle diagnostics",
    },
    {
      "<leader>xd",
      "<CMD>Trouble diagnostics toggle focus=true filter.buf=0<CR>",
      desc = "Document diagnostics",
    },
    {
      "<leader>xq",
      "<CMD>Trouble qflist toggle focus=true<CR>",
      desc = "Quickfix list",
    },
    {
      "<leader>xs",
      "<CMD>Trouble symbols toggle focus=true win.position=right<CR>",
      desc = "Document symbols",
    },
  },
  opts = {},
}

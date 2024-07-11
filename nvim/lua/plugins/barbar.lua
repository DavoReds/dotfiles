return {
  "romgrk/barbar.nvim",
  event = { "BufNewFile", "BufReadPost" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<S-h>",
      "<CMD>BufferPrevious<CR>",
      desc = "Previous buffer",
      silent = true,
    },
    {
      "<S-l>",
      "<CMD>BufferNext<CR>",
      desc = "Next buffer",
      silent = true,
    },
    {
      "<leader>bc",
      "<CMD>BufferClose<CR>",
      desc = "Close buffer",
    },
    {
      "<leader>bp",
      "<CMD>BufferPick<CR>",
      desc = "Pick Buffer",
      silent = true,
    },
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = false,
    auto_hide = 1,
    tabpages = false,
    focus_on_close = "previous",
  },
  version = "^1.0.0",
}

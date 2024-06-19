return {
  "j-hui/fidget.nvim",
  event = { "BufNewFile", "BufReadPost" },
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}

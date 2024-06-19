return {
  "smoka7/hop.nvim",
  opts = {
    multi_windows = true,
    keys = "htnsueoaidgcrlypmbkjvx",
    uppercase_labels = true,
  },
  keys = {
    {
      "<leader>fj",
      function()
        require("hop").hint_words()
      end,
      desc = "Hop to a word",
    },
  },
}

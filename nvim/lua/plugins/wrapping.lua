return {
  "andrewferrier/wrapping.nvim",
  ft = { "markdown" },
  opts = {
    create_keymaps = false,
  },
  config = function(_, opts)
    require("wrapping").setup(opts)
  end,
}

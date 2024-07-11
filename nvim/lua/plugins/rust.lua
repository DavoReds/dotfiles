return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      local crates = require("crates")
      crates.setup({})
      crates.show()
    end,
  },
}

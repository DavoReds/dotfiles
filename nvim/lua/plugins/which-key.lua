return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.register({
      l = { "<CMD>Lazy<CR>", "Lazy" },
    }, {
      mode = "n",
      prefix = "<leader>",
      noremap = true,
      silent = true,
    })

    wk.setup({})
  end,
}

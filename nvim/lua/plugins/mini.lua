return {
  {
    "echasnovski/mini.ai",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
  },
  {
    "echasnovski/mini.move",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
      },
    },
  },
}

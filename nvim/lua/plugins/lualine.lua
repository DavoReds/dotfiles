return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufNewFile", "BufReadPost" },
  opts = {
    options = {
      theme = "catppuccin",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "filesize" },
      lualine_z = { "location" },
    },
  },
}

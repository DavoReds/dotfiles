return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    keys = {
      {
        "<leader><leader>",
        "<cmd>Telescope find_files<CR>",
        desc = "Find files",
      },
      {
        "<leader>ff",
        "<cmd>Telescope git_files<CR>",
        desc = "Find git files",
      },
      {
        "<leader>fa",
        "<cmd>Telescope find_files hidden=true no_ignore=true<CR>",
        desc = "Find all files",
      },
      {
        "<leader>fs",
        "<cmd>Telescope lsp_document_symbols<CR>",
        desc = "Document Symbols",
      },
      {
        "<leader>fS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
        desc = "Workspace Symbols",
      },
      {
        "<leader>fd",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Diagnostics",
      },
      {
        "<leader>fg",
        "<cmd>Telescope live_grep<CR>",
        desc = "Find word in workspace",
      },
      {
        "<leader>fo",
        "<cmd>Telescope oldfiles<CR>",
        desc = "Find recent files",
      },
      {
        "<leader>fr",
        "<cmd>Telescope resume<CR>",
        desc = "Resume last search",
      },
      {
        "<leader>fw",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "Find word in current file",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers<CR>",
        desc = "Find buffers",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = { "BufNewFile", "BufReadPost" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}

return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  version = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = { "BufNewFile", "BufReadPost" },
  opts = {
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "css",
      "csv",
      "dockerfile",
      "dot",
      "gitattributes",
      "gitcommit",
      "git_config",
      "gitignore",
      "git_rebase",
      "go",
      "gomod",
      "gosum",
      "html",
      "htmldjango",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "just",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "nix",
      "python",
      "query",
      "regex",
      "ron",
      "rust",
      "sql",
      "templ",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "zig",
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      bash = { "shfmt" },
      c = { "clang-format" },
      css = { "dprint" },
      dockerfile = { "dprint" },
      html = { "dprint" },
      htmldjango = { "djlint" },
      javascript = { "dprint" },
      json = { "dprint" },
      jsx = { "dprint" },
      just = { "just" },
      lua = { "stylua" },
      markdown = { "dprint" },
      nix = { "alejandra" },
      python = { "dprint" },
      sh = { "shfmt" },
      sql = { "dprint" },
      templ = { "templ" },
      toml = { "dprint" },
      tsx = { "dprint" },
      typescript = { "dprint" },
      typst = { "typstfmt" },
      yaml = { "dprint" },
      zig = { "zigfmt" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 1000, lsp_fallback = true },
    -- Customize formatters
    formatters = {
      ["clang-format"] = {
        prepend_args = { "--style=Chromium" },
      },
      djlint = {
        prepend_args = {
          "--indent",
          "2",
          "--preserve-blank-lines",
          "--max-line-length",
          "80",
        },
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

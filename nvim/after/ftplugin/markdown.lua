vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.colorcolumn = ""

vim.o.foldcolumn = "auto"
vim.o.foldmethod = "marker"

vim.keymap.set("n", "<leader>w", function()
  require("wrapping").toggle_wrap_mode()
end, {
  desc = "Toggle wrapping mode",
  silent = true,
})

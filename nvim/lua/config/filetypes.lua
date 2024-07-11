vim.filetype.add({
  extension = {
    templ = "templ",
  },
  filename = {
    ["Justfile"] = "just",
    ["justfile"] = "just",
    [".justfile"] = "just",
  },
})

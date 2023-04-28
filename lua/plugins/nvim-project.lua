require("project_nvim").setup({
  detection_methods = { "pattern" },
  patterns = {".git", "compile_commands.json", ".nvimrc", ".nvimrc.lua" },
})


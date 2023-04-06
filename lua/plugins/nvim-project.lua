require("project_nvim").setup({
  detection_methods = { "pattern" },
  patterns = {".git", "compile_commands.json", "init.vim", ".nvimrc", ".nvimrc.lua" }
})


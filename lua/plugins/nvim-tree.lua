require('nvim-tree').setup {
  disable_netrw = false,
  git = { enable = true, ignore = true },
  hijack_directories = { enable = true, auto_open = true },
  hijack_netrw = true,
  renderer = {
    highlight_git = true,
    icons = { show = { git = true, folder = true, file = true} },
    indent_markers = { enable = true },
  },
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = { enable = true, update_cwd = true },
  view = { side = 'right', width = 50 },
}


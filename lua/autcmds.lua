local api = vim.api
local cmd = vim.cmd
local opt = vim.opt_local

-- OnOpen/OnRead
api.nvim_create_autocmd({"BufRead","BufNewFile"}, {pattern = {"*/.ssh/config.d/*"}, callback = function(_)
  vim.bo.filetype='sshconfig'
end})

-- FileTypes
---- code files
api.nvim_create_autocmd({"FileType"}, {pattern = {"c", "cpp", "lua"}, callback = function(_)
  opt.colorcolumn="150"
  opt.expandtab=true
  opt.shiftwidth=2
  opt.tabstop=2
end})

---- cucumber files
api.nvim_create_autocmd({"FileType"}, {pattern = {"cucumber", "javascript", "groovy"}, callback = function(_)
  opt.colorcolumn="150"
  opt.expandtab=true
  opt.shiftwidth=4
  opt.tabstop=4
end})

---- text files
api.nvim_create_autocmd({"FileType"}, {pattern = {"asciidoc","markdown","text"}, callback = function(_)
  opt.colorcolumn="200"
  opt.expandtab=true
  opt.shiftwidth=2
  opt.tabstop=2
end})

---- markup files
api.nvim_create_autocmd({"FileType"}, {pattern = {"css","html","scss","xhtml","xml","yaml"}, callback = function(_)
  opt.colorcolumn="150"
  opt.expandtab=true
  opt.shiftwidth=2
  opt.tabstop=2
end})

---- non-files
api.nvim_create_autocmd({"FileType"}, {pattern = {"NvimTree", "qf"}, callback = function(_)
  opt.buflisted = false
end})

api.nvim_create_autocmd({"User"}, {pattern = {"TelescopePreviewerLoaded"}, callback = function(_)
  opt.number = true
end})

-- OnSave
api.nvim_create_autocmd({"BufWritePost"}, {pattern = {"*"}, callback = function(_)
  cmd([[GitGutter]])
end})



local api = vim.api
local opt = vim.opt
local wi = vim.wo

-- General
opt.mouse = 'a'
opt.swapfile = false
opt.colorcolumn = '80'
opt.signcolumn = 'yes:1'
opt.exrc = true
opt.clipboard = 'unnamed,unnamedplus'
opt.scrolloff = 5

-- Tabs and indents
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true

-- NeoVim UI
opt.syntax = 'off' -- covered by TreeSitter
opt.number = true
opt.relativenumber = false
opt.listchars = {tab = '▸ ', nbsp='␣', trail = '•', extends = '⟩', precedes = '⟨'} --, eol = '↲'}
opt.list = true
opt.showbreak = '↪'
opt.laststatus = 2
opt.ruler = true
opt.fileformats = 'unix,dos'
opt.wildoptions = 'pum'
wi.cursorline = true
wi.wrap = false
api.nvim_set_hl(0, 'CursorLine', {underline = true})


-- Memory CPU
opt.hidden = true
opt.history = 1000
opt.synmaxcol = 500

-- Tabs indent
-- Autocompletion
opt.completeopt = 'menuone,noselect,noinsert'


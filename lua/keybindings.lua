local mgp = require 'key-menu'.set
local DEFAULT_OPS = { noremap = true, silent = true }

local function map(mode, lhs, rhs, opts)
  local options = DEFAULT_OPS
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- overall
vim.g.mapleader = ' '
mgp('n', '<Space>')

-- buffer navigation
map('n', '<A-Left>',   ':SelectPrevBuffer<CR>',   { desc = 'Select Previous Buffer' })
map('n', '<A-Right>',  ':SelectNextBuffer<CR>',   { desc = 'Select Next Buffer' })
map('n', '<Leader>q',  ':CloseCurrentBuffer<CR>', { desc = 'Close Buffer' })
map('n', '<Leader>b',  ':ShowBuffers<CR>',        { desc = 'Show Buffers'})

-- spellcheck
mgp('n', '<Leader>s', { desc = 'Spellchecker' })
map('n', '<F1>',       ':ToggleSpellcheck<CR>',        { desc = 'Toggle Spellchecker' })
map('n', '<Leader>st', ':ToggleSpellcheck<CR>',        { desc = 'Toggle Spellchecker' })
map('n', '<S-F1>',     ':ApplySpellingSuggestion<CR>', { desc = 'Correct Spelling' })
map('n', '<Leader>ss', ':ApplySpellingSuggestion<CR>', { desc = 'Correct Spelling' })
map('n', '<Leader>sn', ':GotoNextSpellingError<CR>',   { desc = 'Goto Next Spelling Error' })
map('n', '<Leader>sp', ':GotoPrevSpellingError<CR>',   { desc = 'Goto Previous Spelling Error' })
map('n', '<Leader>sg', ':MarkSpellingGood<CR>',        { desc = 'Mark Spelling as Good' })
map('n', '<Leader>sb', ':MarkSpellingBad<CR>',         { desc = 'Mark Spelling as Bad' })

-- searching
map('n', '<F2>',       ':ToggleSearchHighlighting<CR>', { desc = 'Toggle Search Highlighting' })
map('n', '<F3>',       ':Search<CR>',                   { desc = 'Search Word under Cursor' })
map('v', '<F3>',       ':Search<CR>',                   { desc = 'Search Selection' })
map('n', '<S-F3>',     ':ShowSearchResults<CR>',        { desc = 'Search Word under Cursor in Project' })
map('v', '<S-F3>',     ':ShowSearchResults<CR>',        { desc = 'Search Selection in Project' })

-- highlighting
map('n', '<F4>',       ':ToggleSyntax<CR>',              { desc = 'Toggle Syntax Highlighting' })
map('n', '<S-F4>',     ':ToggleInvisibleCharacters<CR>', { desc = 'Toggle Invisible Character' })

-- misc
map('n', '<F5>',       ':GitGutter<CR>',                { desc = 'Update GitGutter' })

-- code diagnostics
map('n', '<F6>',       ':ShowLineDiagnostics<CR>', { desc = 'Show Current Diagnostics' })
map('n', '<S-F6>',     ':ShowDiagnosticsList<CR>', { desc = 'Show All Diagnostics' })
map('n', '<F7>',       ':GotoPrevDiagnostic<CR>',  { desc = 'Goto Previous Diagnostic' })
map('n', '<S-F7>',     ':ShowDiagnosticsList<CR>', { desc = 'Show All Diagnostics' })
map('n', '<F8>',       ':GotoNextDiagnostic<CR>',  { desc = 'Goto Next Diagnostic' })
map('n', '<S-F8>',     ':ShowDiagnosticsList<CR>', { desc = 'Show All Diagnostics' })

-- code actions
map('n', '<F9>',       ':RunCodeAction<CR>', { desc = 'Code Action' })
map('v', '<F9>',       ':RunCodeAction<CR>', { desc = 'Code Action' })
map('n', '<S-F9>',     ':RenameSymbol<CR>',  { desc = 'Refactor Rename' })

-- code navigation
map('n', '<F11>',      ':ShowTypeDefinitions<CR>', { desc = 'Goto Type Definition' })
map('n', '<S-F11>',    ':ShowSignatureHelp<CR>',   { desc = 'Signature Help' })
map('n', '<F12>',      ':GotoDefinition<CR>',      { desc = 'Goto Definition' })
map('n', '<S-F12>',    ':ShowReferences<CR>',      { desc = 'Show References' })

-- workspaces
mgp('n', '<Leader>w', { desc = 'Workspace' })
map('n', '<Leader>wa', ':AddWorkspaceFolder<CR>',    { desc = 'Add Workspace Folder' })
map('n', '<Leader>wr', ':RemoveWorkspaceFolder<CR>', { desc = 'Remove Workspace Folder' })
map('n', '<Leader>wl', ':ShowWorkspaceFolders<CR>',  { desc = 'List Workspace Folders' })

-- nvim-tree
map('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>', { desc = 'Toggle Tree' })

-- gitgutter
mgp('n', '<Leader>h', { desc = 'Git' })
map('n', '<Leader>hh', ':GitGutterLineHighlightsToggle<CR>', { desc = 'Toggle Highlights' })
map('n', '<Leader>hf', ':GitGutterFold<CR>',                 { desc = 'Toggle Folding' })
map('n', '<Leader>hp', ':GitGutterPreviewHunk<CR>',          { desc = 'Preview Hunk' })
map('n', '<Leader>hs', ':GitGutterStageHunk<CR>',            { desc = 'Stage Hunk' })
map('n', '<Leader>hu', ':GitGutterUndoHunk<CR>',             { desc = 'Undo Hunk' })

-- file handing
mgp('n', '<Leader>f', { desc = 'Files'})
map('n', '<Leader>ff', ':FindFiles<CR>',           { desc = 'Find Files'})
map('n', '<Leader>fg', ':GrepFiles<CR>',           { desc = 'Grep Files'})
map('n', '<Leader>fo', ':ShowOldFiles<CR>',        { desc = 'Show Old Files'})
map('n', '<Leader>fr', ':ResumeTelescopeView<CR>', { desc = 'Resume Last Picker'})



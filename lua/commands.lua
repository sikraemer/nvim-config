local telescope_builtin = require('telescope.builtin')

-------------------------------------------------------------------------------
-- Buffer Navigation
function SelectNextBuffer()
  vim.cmd([[bn]])
end
vim.api.nvim_create_user_command('SelectNextBuffer', SelectNextBuffer, {})

function SelectPrevBuffer()
  vim.cmd([[bp]])
end
vim.api.nvim_create_user_command('SelectPrevBuffer', SelectPrevBuffer, {})

function CloseCurrentBuffer()
  if pcall(function ()
    vim.cmd([[bp|bd #]]) -- select previous - then delete last
  end) then else
    vim.cmd([[bd]]) -- delete last buffer directly
  end
end
vim.api.nvim_create_user_command('CloseCurrentBuffer', CloseCurrentBuffer, {})

-------------------------------------------------------------------------------
-- Syntax Highlighting
function ToggleSyntax()
  local syntax = vim.opt.syntax._value
  vim.cmd([[TSBufToggle highlight]])
  vim.opt.syntax = syntax
end
vim.api.nvim_create_user_command('ToggleSyntax', ToggleSyntax, {})

function ToggleInvisibleCharacters()
  vim.opt.list = not vim.opt.list._value
end
vim.api.nvim_create_user_command('ToggleInvisibleCharacters', ToggleInvisibleCharacters, {})

-------------------------------------------------------------------------------
-- Spellchecker
function ToggleSpellcheck()
  vim.opt.spell = not vim.opt.spell._value
end
vim.api.nvim_create_user_command('ToggleSpellcheck', ToggleSpellcheck, {})

function ApplySpellingSuggestion()
  vim.cmd([[normal z=]])
end
vim.api.nvim_create_user_command('ApplySpellingSuggestion', ApplySpellingSuggestion, {})

function GotoNextSpellingError()
  vim.cmd([[normal ]s]])
end
vim.api.nvim_create_user_command('GotoNextSpellingError', GotoNextSpellingError, {})

function GotoPrevSpellingError()
  vim.cmd([[normal [s]])
end
vim.api.nvim_create_user_command('GotoPrevSpellingError', GotoPrevSpellingError, {})

function MarkSpellingGood()
  vim.cmd([[normal zg]])
end
vim.api.nvim_create_user_command('MarkSpellingGood', MarkSpellingGood, {})

function MarkSpellingBad()
  vim.cmd([[normal zw]])
end
vim.api.nvim_create_user_command('MarkSpellingBad', MarkSpellingBad, {})

-------------------------------------------------------------------------------
-- Search

local function GetSearchText(opts)
  local search_text=""
  if opts.range == 0 then
    search_text = vim.fn.expand('<cword>')
  else
    local selection_start = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
    local selection_end   = vim.fn.getpos("'>") -- [bufnum, lnum, col, off]
    local selected_lines  = vim.fn.getline(selection_start[2], selection_end[2])

    local index_start = 1
    local index_end = #selected_lines
    selected_lines[index_end]   = string.sub(selected_lines[index_end], 0, selection_end[3])
    selected_lines[index_start] = string.sub(selected_lines[index_start], selection_start[3])

    search_text = table.concat(selected_lines, '\n')
  end
  return search_text
end

function ShowSearchResults(opts)
  local search_text = GetSearchText(opts)
  vim.cmd("/\\V" .. search_text:gsub("\n", "\\n")) -- Search
  vim.cmd("normal N") -- Select initial occurence
  telescope_builtin.grep_string({search=search_text, word_match="-w"})
end
vim.api.nvim_create_user_command('ShowSearchResults', ShowSearchResults, {range = true})

function Search(opts)
  local search_text = GetSearchText(opts)
  vim.opt.hlsearch = false -- Enable highlighting
  vim.cmd("/\\V" .. search_text:gsub("\n", "\\n")) -- Search
  vim.cmd("normal N") -- Select initial occurence
  vim.opt.hlsearch = true -- Enable highlighting
end
vim.api.nvim_create_user_command('Search', Search, {range = true})

function ToggleSearchHighlighting()
  vim.opt.hlsearch = not vim.opt.hlsearch._value
end
vim.api.nvim_create_user_command('ToggleSearchHighlighting', ToggleSearchHighlighting, {})

-------------------------------------------------------------------------------
-- Code Navigation
function ShowReferences(_)
  telescope_builtin.lsp_references()
end
vim.api.nvim_create_user_command('ShowReferences', ShowReferences, {})

function ShowSignatureHelp(_)
  vim.lsp.buf.signature_help()
end
vim.api.nvim_create_user_command('ShowSignatureHelp', ShowSignatureHelp, {})

function ShowTypeDefinitions(_)
  telescope_builtin.lsp_type_definitions()
end
vim.api.nvim_create_user_command('ShowTypeDefinitions', ShowTypeDefinitions, {})

function GotoDefinition(_)
  telescope_builtin.lsp_definitions()
end
vim.api.nvim_create_user_command('GotoDefinition', GotoDefinition, {})

-------------------------------------------------------------------------------
-- Code Diagnostic
function GotoPrevDiagnostic(_)
  vim.diagnostic.goto_prev()
end
vim.api.nvim_create_user_command('GotoPrevDiagnostic', GotoPrevDiagnostic ,{})

function GotoNextDiagnostic(_)
  vim.diagnostic.goto_next()
end
vim.api.nvim_create_user_command('GotoNextDiagnostic', GotoNextDiagnostic ,{})

function HoverLineDiagnostic(_)
  vim.lsp.buf.hover()
end
vim.api.nvim_create_user_command('HoverLineDiagnostic', HoverLineDiagnostic ,{})

function ShowLineDiagnostics(_)
  vim.diagnostic.open_float()
end
vim.api.nvim_create_user_command('ShowLineDiagnostics', ShowLineDiagnostics ,{})

function ShowDiagnostics(_)
  telescope_builtin.diagnostics({bufnr=0})
end
vim.api.nvim_create_user_command('ShowDiagnostics', ShowDiagnostics ,{})

-------------------------------------------------------------------------------
-- Code Actions
function RunCodeAction(opts)
  if opts.range == 0 then
    vim.lsp.buf.code_action()
  else
    vim.lsp.buf.range_code_action()
  end
end
vim.api.nvim_create_user_command('RunCodeAction', RunCodeAction, {range = true})

function RenameSymbol(_)
  vim.lsp.buf.rename()
end
vim.api.nvim_create_user_command('RenameSymbol', RenameSymbol ,{})

--------------------------------------------------------------------------------
-- Workspace
function AddWorkspaceFolder()
  vim.lsp.buf.add_workspace_folder()
end
vim.api.nvim_create_user_command('AddWorkspaceFolder', AddWorkspaceFolder ,{})

function RemoveWorkspaceFolder()
  vim.lsp.buf.remove_workspace_folder()
end
vim.api.nvim_create_user_command('RemoveWorkspaceFolder', RemoveWorkspaceFolder ,{})

function ShowWorkspaceFolders()
  vim.inspect(vim.lsp.buf.list_workspace_folders())
end
vim.api.nvim_create_user_command('ShowWorkspaceFolders', ShowWorkspaceFolders ,{})

--------------------------------------------------------------------------------
-- Files
function FindFiles()
  telescope_builtin.find_files()
end
vim.api.nvim_create_user_command('FindFiles', FindFiles ,{})

function GrepFiles()
  telescope_builtin.live_grep()
end
vim.api.nvim_create_user_command('GrepFiles', GrepFiles ,{})

function ShowBuffers()
  telescope_builtin.buffers()
end
vim.api.nvim_create_user_command('ShowBuffers', ShowBuffers ,{})

function ShowOldFiles()
  telescope_builtin.oldfiles()
end
vim.api.nvim_create_user_command('ShowOldFiles', ShowOldFiles ,{})

function ResumeTelescopeView()
  telescope_builtin.resume()
end
vim.api.nvim_create_user_command('ResumeTelescopeView', ResumeTelescopeView ,{})


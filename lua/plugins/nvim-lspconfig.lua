local nvim_lsp = require('lspconfig')
local nvim_lsp_sig = require('lsp_signature')

if(not vim.g.lsp_cmake_builddir) then
  vim.g.lsp_cmake_builddir = "build"
end

-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  nvim_lsp_sig.on_attach()
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

-- clangd
nvim_lsp["clangd"].setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--completion-style=bundled",
    "--header-insertion=iwyu"
  },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {debounce_text_changes = 150},
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- lua
nvim_lsp["lua_ls"].setup {
  settings = {
      Lua = {
          diagnostics = {globals = {"vim", "use", "packer_plugins"}},
          telemetry = {enable = false},
          workspace = {library = vim.api.nvim_get_runtime_file('', true)}
      }
  },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
}

-- cmake
nvim_lsp["cmake"].setup {
  init_options = { buildDirectory = "Build/Host-Debug" },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {debounce_text_changes = 150},
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- groovy
nvim_lsp["groovyls"].setup {
  cmd = { "java", "-jar" , "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" },
  filetypes = { "groovy", "java"},
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {debounce_text_changes = 150},
}

-- java
nvim_lsp["java_language_server"].setup {
  cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 }
}

-- python
nvim_lsp["pyright"].setup {
  before_init = function(_, config)
    if vim.fn.executable('pyenv') == 1 then
      config.settings.python.pythonPath = os.capture('pyenv which python', false)
    end
  end,
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.root_pattern('.python-version', '.git', 'lib')
}

-- rest
for _, server in pairs({ 'bashls', 'vimls', 'dockerls'}) do
  nvim_lsp[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    root_dir = nvim_lsp.util.find_git_ancestor
  }
end


local nvim_lsp = require('lspconfig')
local nvim_lsp_sig = require('lsp_signature')
local functions = require('../functions')

local M = {}

-------------------------------------------------------------------------------

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } },
}

M.on_attach = function(_, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  nvim_lsp_sig.on_attach()
end

-------------------------------------------------------------------------------

M.language_servers = {}

-- c++ clangd
M.language_servers.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--completion-style=bundled",
    "--header-insertion=iwyu"
  },
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150},
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- lua
M.language_servers.lua_ls = {
  settings = {
      Lua = {
          diagnostics = {globals = {"vim", "use", "packer_plugins"}},
          telemetry = {enable = false},
          workspace = {library = vim.api.nvim_get_runtime_file('', true)}
      }
  },
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150}
}

-- cmake
M.language_servers.cmake = {
  init_options = { buildDirectory = "Build/Host-Debug" },
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150},
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- groovy
M.language_servers.groovyls = {
  cmd = { "java", "-jar" , "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" },
  filetypes = { "groovy", "java"},
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150},
}

-- java
M.language_servers.java_language_server = {
  cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 }
}

-- python pyright
M.language_servers.pyright = {
  before_init = function(_, config)
    if vim.fn.executable('pyenv') == 1 then
      config.settings.python.pythonPath = functions.os.capture('pyenv which python', false)
    end
  end,
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.root_pattern('.python-version', '.git')
}

-- bashls
M.language_servers.bashls = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- vimls
M.language_servers.vimls = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- dockerls
M.language_servers.dockerls = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- efm (multi-language-support)
--  - python pylint
--  - python mypy
--  - python yapf
--  - python isort
--  - 
M.language_servers.efm = {
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor,
  filetypes = {
    'python',
  },
  settings = {
    languages = {
      python = {
        -- pylint
        {
          lintCommand = 'pylint --output-format text --score no --msg-template {path}={line}={column}={C}={msg} ${INPUT}',
          lintIgnoreExitCode = true,
          lintStdin = false,
          lintFormats = {
            '%f=%l=%c=%t=%m'
          },
          lintOffsetColumns = 1,
          lintCategoryMap = {
            I = 'H',
            R = 'I',
            C = 'I',
            W = 'W',
            E = 'E',
            F = 'E',
          }
        },
        -- mypy
        {
          lintCommand = 'mypy --show-column-numbers',
          lintIgnoreExitCode = true,
          lintFormats = {
            '%f=%l=%c= %trror= %m',
            '%f=%l=%c= %tarning= %m',
            '%f=%l=%c= %tote= %m'
          }
        },
        -- isort
        {
          formatCommand = 'isort --quiet -',
          formatStdin = true
        },
        -- yapf
        {
          formatCommand = 'yapf --quiet',
          formatStdin = true
        }
      }
    }
  }
}


-------------------------------------------------------------------------------

M.setup = function()
    if(not vim.g.lsp_cmake_builddir) then
        vim.g.lsp_cmake_builddir = "build"
    end

    for language_server, language_server_config in pairs(M.language_servers) do
      if language_server ~= nil and language_server_config ~= nil then
        nvim_lsp[language_server].setup(language_server_config)
      end
    end
end

return M


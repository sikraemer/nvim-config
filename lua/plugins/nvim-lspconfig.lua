local nvim_lsp = require('lspconfig')
local nvim_lsp_configs = require('lspconfig.configs')
local nvim_lsp_sig = require('lsp_signature')
local functions = require('../functions')

local M = {}

-------------------------------------------------------------------------------

M.default_capabilities = vim.lsp.protocol.make_client_capabilities()

M.on_attach = function(config, bufnr)
  nvim_lsp_sig.on_attach(config, bufnr)
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
  capabilities = M.default_capabilities,
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
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150}
}

-- cmake
M.language_servers.cmake = {
  init_options = { buildDirectory = "Build/Host-Debug" },
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150},
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- groovy
M.language_servers.groovyls = {
  cmd = { "java", "-jar" , "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" },
  filetypes = { "groovy", "java"},
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = {debounce_text_changes = 150},
}

-- java
M.language_servers.java_language_server = {
  cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
  capabilities = M.default_capabilities,
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
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.root_pattern('.python-version', '.git')
}

-- bashls
M.language_servers.bashls = {
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- vimls
M.language_servers.vimls = {
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- dockerls
M.language_servers.dockerls = {
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor
}

-- python pylint
M.language_servers.pylint = {
  inherits = "efm",
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor,
  filetypes = { 'python' },
  settings = {
    languages = {
      python = {{
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
        }}
      }
    }
  }
}

-- python mypy
M.language_servers.mypy = {
  inherits = "efm",
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor,
  filetypes = { 'python' },
  settings = {
    languages = {
      python = {{
        lintCommand = 'mypy --show-column-numbers',
        lintIgnoreExitCode = true,
        lintFormats = {
          '%f=%l=%c= %trror= %m',
          '%f=%l=%c= %tarning= %m',
          '%f=%l=%c= %tote= %m'
        }}
      }
    }
  }
}

M.language_servers.isort = {
  inherits = "efm",
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor,
  filetypes = { 'python' },
  settings = {
    languages = {
      python = {{
        formatCommand = 'isort --quiet -',
        formatStdin = true
      }}
    }
  }
}

M.language_servers.yapf = {
  inherits = "efm",
  capabilities = M.default_capabilities,
  on_attach = M.on_attach,
  flags = { debounce_text_changes = 150 },
  root_dir = nvim_lsp.util.find_git_ancestor,
  filetypes = { 'python' },
  settings = {
    languages = {
      python = {{
        formatCommand = 'yapf --quiet',
        formatStdin = true
      }}
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
      if language_server_config.inherits ~= nil and nvim_lsp_configs[language_server] == nil then
        nvim_lsp_configs[language_server] = require('lspconfig.server_configurations.' .. language_server_config.inherits)
      end
      nvim_lsp[language_server].setup(language_server_config)
    end
  end
end

nvim_lsp.pyright.setup({})

return M


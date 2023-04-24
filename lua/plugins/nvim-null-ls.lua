local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.yapf,

        -- Bash
        null_ls.builtins.diagnostics.shellcheck,

        -- CMake
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.formatting.cmake_format,

        -- C++
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.gccdiag,

        -- json
        null_ls.builtins.diagnostics.jsonlint,

        -- asciidoc
        null_ls.builtins.diagnostics.vale,

        -- Groovy, Jenkinsfile
        null_ls.builtins.diagnostics.npm_groovy_lint,
        null_ls.builtins.formatting.npm_groovy_lint,
  },
})

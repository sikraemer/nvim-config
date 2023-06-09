local config_local = require('config-local')
config_local.setup({
    config_files = { ".nvimrc.lua", ".nvimrc" },  -- Config file patterns to load (lua supported)
    hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
    autocommands_create = true,                 -- Create autocommands (VimEnter, DirectoryChanged)
    commands_create = true,                     -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
    silent = true,                             -- Disable plugin messages (Config loaded/ignored)
    lookup_parents = true,                     -- Lookup config files in parent directories
})

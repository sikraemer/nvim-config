require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
  use { 'neovim/nvim-lspconfig',
    requires = {
      'ray-x/lsp_signature.nvim',
      'hrsh7th/nvim-cmp'
    }
  }
  use { 'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
      opt = true
    }
  }
  use {'akinsho/bufferline.nvim', tag = "v3.*",
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  use { 'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp' ,
      'hrsh7th/cmp-buffer' ,
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip'
    }
  }
  use { 'L3MON4D3/LuaSnip', tag = 'v2.*', run = 'make install_jsregexp',
    requires = { 'rafamadriz/friendly-snippets' }
  }
  use { 'airblade/vim-gitgutter', branch = 'main' }
  use { 'folke/tokyonight.nvim' }
  use { 'ahmedkhalf/project.nvim' }
  use { 'linty-org/key-menu.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'junegunn/vim-easy-align' }
  use { 'klen/nvim-config-local', tag = "1.*" }
  use { 'rcarriga/nvim-notify' }
  use {
    'mrded/nvim-lsp-notify',
    requires = { 'rcarriga/nvim-notify' }, }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {'nvim-lua/plenary.nvim'}
  }
end)

require('plugins/nvim-tokyonight')
require('plugins/nvim-colorizer')

require('plugins/nvim-notify')
require('plugins/nvim-lsp-notify')

require('plugins/nvim-project')
require('plugins/nvim-config-local')

require('plugins/nvim-tree')
require('plugins/nvim-lualine')
require('plugins/bufferline')

require('plugins/nvim-treesitter')
require('plugins/vim-gitgutter')

require('plugins/nvim-lsp-signature')
require('plugins/nvim-cmp')


require('plugins/nvim-telescope')

-- Initialize the following after the project local config was loaded
vim.api.nvim_create_autocmd({"User"}, {pattern = {"ConfigFinished"}, callback = function(_)
  require('plugins/luasnip')
  require('plugins/nvim-lspconfig').setup()
  pcall(function() vim.cmd[[e]] end)
end})



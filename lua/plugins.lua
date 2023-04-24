require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'ray-x/lsp_signature.nvim' }
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
      'L3MON4D3/LuaSnip' ,
      'hrsh7th/cmp-nvim-lsp' ,
      'hrsh7th/cmp-buffer' ,
      'hrsh7th/cmp-path'
    }
  }
  use { 'hrsh7th/vim-vsnip' }
  use { 'airblade/vim-gitgutter' }
  use { 'rhysd/vim-clang-format' }
  use { 'folke/tokyonight.nvim' }
  use { 'ahmedkhalf/project.nvim' }
  use { 'linty-org/key-menu.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'junegunn/vim-easy-align' }
  use { 'klen/nvim-config-local' }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    "danymat/neogen", tag = "*",
    requires = {"nvim-treesitter/nvim-treesitter"},
  }
end)

require('plugins/nvim-tokyonight')
require('plugins/nvim-colorizer')

require('plugins/nvim-project')
require('plugins/nvim-config-local')

require('plugins/nvim-tree')
require('plugins/nvim-lualine')
require('plugins/bufferline')

require('plugins/nvim-null-ls')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')

require('plugins/vim-clang-format')
require('plugins/vim-gitgutter')
require('plugins/neogen')

require('plugins/nvim-telescope')
require('plugins/nvim-lsp-signature')
require('plugins/nvim-cmp')


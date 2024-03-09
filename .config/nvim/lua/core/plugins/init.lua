local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'nvim-treesitter/nvim-treesitter'
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use { 'akinsho/bufferline.nvim',
    requires = { { 'nvim-tree/nvim-web-devicons' } }
  }
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim'
  }
  use 'lewis6991/gitsigns.nvim'
  use { "akinsho/toggleterm.nvim", tag = '*' }
  if packer_bootstrap then
    require('packer').sync()
  end
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp", "onsails/lspkind-nvim", "L3MON4D3/LuaSnip"
    }
  }
  use 'wakatime/vim-wakatime'
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "andweeb/presence.nvim" })
  use {
    'xeluxee/competitest.nvim',
    requires = { 'MunifTanjim/nui.nvim' },
  }
  use {
    "Exafunction/codeium.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      })
    end
  }
end)


local enabled_plugins = {
  'lualine',
  'bufferline',
  'nvim-tree',
  'treesitter',
  'telescope',
  'theme',
  'lspconfig',
  'nvim-cmp',
  'gitsigns',
  'lazygit',
  'null-ls',
  'indent-blankline',
  'compitest'
};
for _, plugin in pairs(enabled_plugins) do
  require('core.plugins.plugin_config.' .. plugin)
end

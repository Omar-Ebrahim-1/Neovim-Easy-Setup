local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
  {'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim'},
  'stevearc/dressing.nvim',
  'navarasu/onedark.nvim',
  'tpope/vim-fugitive',
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'numToStr/Comment.nvim',
  'kylechui/nvim-surround',
  'folke/which-key.nvim',
  'norcalli/nvim-colorizer.lua',
  'm4xshen/autoclose.nvim',
  'github/copilot.vim',
  {'Wansmer/treesj', dependencies = 'nvim-treesitter/nvim-treesitter'},
  {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},
  "lukas-reineke/indent-blankline.nvim",
  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-refactor',

  -- LSP
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'onsails/lspkind-nvim',
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    'creativenull/efmls-configs-nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  "folke/neoconf.nvim",

  -- Snippets
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',
}
require("lazy").setup(plugins, {})

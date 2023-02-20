--[[
-- My Neovim
--]]
--
--[[
-- Packer startup
--]]
--
-- Lazy
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
require("lazy").setup({
  "folke/which-key.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  "jose-elias-alvarez/null-ls.nvim",
  'windwp/nvim-autopairs',
  { "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'simrat39/symbols-outline.nvim' },
  { "frabjous/knap" },
  { "nvim-treesitter/nvim-treesitter" },
  "kylechui/nvim-surround",
  'kevinhwang91/rnvimr',
  "MunifTanjim/nui.nvim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },
  'feline-nvim/feline.nvim',
  { 'romgrk/barbar.nvim',   dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  { "rrethy/vim-illuminate" },
  {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' } },
  "akinsho/toggleterm.nvim",
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  "lukas-reineke/indent-blankline.nvim",
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }, },
  { 'sunjon/stylish.nvim' },
})



require("Mehjush.options")
require("Mehjush.maps")
require("Mehjush.Neotree")
require("Mehjush.Configs")
require("Mehjush.Formatter")
require("Mehjush.lsp")
require("Mehjush.ts")
require("Mehjush.Alpha")
require("Mehjush.Autopairs")
require("Mehjush.barbarConf")
require("Mehjush.Terms")

vim.cmd('colorscheme onedark_dark')

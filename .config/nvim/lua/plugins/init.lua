return {
    { 'projekt0n/github-nvim-theme' },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", 
        "MunifTanjim/nui.nvim",
      }
    },
    { 'windwp/nvim-autopairs' },
    { 'numToStr/Comment.nvim' }
  }
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },
  {
    'chipsenkbeil/distant.nvim', 
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
  },
  { 
    'https://codeberg.org/esensar/nvim-dev-container' 
  },
  --remote nvim
   {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = true,
  }, 
  {
   "nvim-tree/nvim-tree.lua",
   dependencies = {
     "nvim-tree/nvim-web-devicons"
   },
   version = "v1",
   config = true,
   },
   {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
        processor = "magick_cli",
    }
  }
}

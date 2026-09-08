vim.g.editorconfig = false

vim.opt.tabstop=2
vim.opt.shiftwidth=2

vim.opt.expandtab=true

require("config.lazy")
require("nvim-tree.api").tree.open()

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with a config

--@type nvim_tree.config
local config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
require("nvim-tree").setup(config)

--nvim autocmd stuff
--vim.api.nvim_create_autocmd("VimEnter", {
--  callback = function()
--    vim.cmd("NvimTreeToggle")
--  end,
--})

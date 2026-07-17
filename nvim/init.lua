-- require base files
require "opts"
require "keymaps"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("config.lazy")

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.opt.cmdheight = 1


-- ignore /search case sensitivity, but if case sensitive. it will take into account
vim.o.ignorecase = true
vim.o.smartcase = true

-- bottom bar stays bottom when resizing the window
vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
   group = vim.api.nvim_create_augroup("FixCmdHeight", { clear = true }),
   callback = function()
      vim.opt.cmdheight = 1
   end,
})

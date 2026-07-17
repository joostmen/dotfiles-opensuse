return {
   {
      "vim-airline/vim-airline",
      dependencies = {
         "vim-airline/vim-airline-themes",
      },
      init = function()
         -- Enable the tabline (buffers) at the top of your screen
         vim.g["airline#extensions#tabline#enabled"] = 1

         -- Ensure Powerline fonts (Nerd Fonts) display correctly
         vim.g.airline_powerline_fonts = 1

         -- Set a specific theme (change to match your colorscheme)
         vim.g.airline_theme = "base16_gruvbox_dark_hard"
      end,
   },
}

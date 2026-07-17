-- In your plugins file, e.g. ~/.config/nvim/lua/plugins/comment.lua
return {
   "numToStr/Comment.nvim",
   config = function()
      require("Comment").setup({
         padding = true, -- add space after comment marker
         sticky = true, -- keep cursor on same line
         ignore = "^$", -- ignore empty lines
         mappings = {
            basic = true, -- enable default gcc/gc mappings
            extra = true, -- enable extra mappings (e.g. gco, gcO, gcA)
            extended = false, -- more advanced mappings
         },
      })
   end,
}

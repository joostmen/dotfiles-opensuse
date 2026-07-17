return {
   {
      "folke/edgy.nvim",
      event = "VeryLazy",
      opts = {
         right = {
            {
               title = "Symbols",
               ft = "aerial",
               size = { width = 28 },
            },
         },
         bottom = {
            {
               title = "Quickfix",
               ft = "qf",
               size = { height = 10 },
            },
         },
         options = {
            right = { size = 12 },
            bottom = { size = 12 },
         },
      },
   },
}
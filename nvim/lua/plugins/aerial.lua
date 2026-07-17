return {
   {
      "stevearc/aerial.nvim",
      opts = {
         layout = {
            default_direction = "right",
            width = 34,
         },
         show_guides = true,
      },
      dependencies = {
         "nvim-tree/nvim-web-devicons",
      },
      keys = {
         { "<leader>ss", "<cmd>AerialToggle<CR>", desc = "Code symbols" },
      },
   },
}


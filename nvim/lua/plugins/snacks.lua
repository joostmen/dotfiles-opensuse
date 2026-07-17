return {
   {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
         bigfile = { enabled = true },
         bufdelete = { enabled = true },
         dashboard = { enabled = true },
         explorer = { enabled = true },
         indent = { enabled = true },
         lazygit = { enabled = true },
         notifier = {
            enabled = true,
            timeout = 3000,
         },
         picker = {
            enabled = true,
            sources = {
               explorer = {
                  layout = {
                     preview = false,
                     layout = {
                        backdrop = false,
                        width = 40,
                        min_width = 40,
                        height = 0,
                        position = "left",
                        border = "none",
                        box = "vertical",
                        {
                           win = "input",
                           height = 1,
                           border = true,
                           title = "Explorer",
                           title_pos = "center",
                        },
                        
                        {
                           win = "list",
                           border = true,
                        },
                     },
                  },
                  win = {
                     input = {
                        wo = {
                           statusline = " ",
                           winbar = "",
                        },
                     },
                     list = {
                        wo = {
                           statusline = " ",
                           winbar = "",
                        },
                     },
                  },
               },
            },
         },
         quickfile = { enabled = true },
         rename = { enabled = true },
         scratch = { enabled = true },
         scroll = { enabled = true },
         statuscolumn = { enabled = true },
         terminal = {
            enabled = true,
            win = {
               position = "bottom",
               height = 12,
            },
         },
         zen = { enabled = true },
      },
   },
}
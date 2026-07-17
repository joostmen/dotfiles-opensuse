return {
   {
      "neoclide/coc.nvim",
      branch = "release",
      lazy = false,
      config = function()
         vim.g.coc_global_extensions = {
            "coc-pyright",       -- Python
            "coc-texlab",
            "coc-yank",
            "coc-json",          -- JSON
            "coc-markdownlint",  -- Markdown diagnostics
            "coc-vimtex",        -- LaTeX support if you use vimtex
            "coc-snippets",
            "coc-pairs",         -- bracket opening and closing
         }
         local keymap = vim.keymap.set
         local opts = { noremap = true, silent = true }

         keymap("n", "K", function()
            vim.fn.CocActionAsync("doHover")
         end, { noremap = true, silent = true, desc = "Show documentation" })

         keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
         keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
         keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
         keymap("n", "<leader>lr", "<Plug>(coc-rename)", { silent = true })
         keymap("n", "<leader>la", "<Plug>(coc-codeaction-cursor)", { silent = true })

         keymap("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], {
            expr = true,
            noremap = true,
            silent = true,
         })

         keymap("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]], {
            expr = true,
            noremap = true,
            silent = true,
         })

         keymap("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], {
            expr = true,
            noremap = true,
            silent = true,
         })
         vim.keymap.set("n", "<leader>ls", ":CocList outline<CR>", { silent = true, desc = "Document symbols" })
         vim.keymap.set("n", "<leader>lw", ":CocList symbols<CR>", { silent = true, desc = "Workspace symbols" })
         vim.keymap.set("n", "<leader>ld", ":CocList diagnostics<CR>", { silent = true, desc = "Diagnostics" })
      end,
   },
}

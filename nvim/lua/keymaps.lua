-- keymaps for fuzzy find
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- wordwrap
keymap("n", "<leader>ww", function()
   local new = not vim.opt.wrap:get()
   vim.opt.wrap = new
   vim.opt.linebreak = new
end, { desc = "Toggle word wrap + linebreak" })

-- General keymaps
keymap("n", "<leader>ll", "<cmd>Lazy<CR>", opts)

keymap("n", "<leader>e", function()
   Snacks.explorer()
end, { desc = "Open file explorer" })

keymap("i", "<C-BS>", "<C-w>", { desc = "Delete word backwards like in vscode" })

-- Terminal
keymap("n", "<leader>tt", function()
   Snacks.terminal()
end, { desc = "Toggle terminal" })

keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], {
   noremap = true,
   silent = true,
   desc = "Exit terminal mode",
})

-- window management
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<A-Up>", "<cmd>resize +2<CR>", { desc = "Taller" })
keymap("n", "<A-Down>", "<cmd>resize -2<CR>", { desc = "Shorter" })
keymap("n", "<A-Right>", "<cmd>vertical resize +4<CR>", { desc = "Wider" })
keymap("n", "<A-Left>", "<cmd>vertical resize -4<CR>", { desc = "Narrower" })

-- buffer management
keymap("n", "<Tab>", "<cmd>bnext<CR>", {
   noremap = true,
   silent = true,
   desc = "Next buffer",
})

keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", {
   noremap = true,
   silent = true,
   desc = "Previous buffer",
})

keymap("n", "<leader>db", function()
   Snacks.bufdelete()
end, { desc = "Delete buffer" })

-- tab keymaps
keymap("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
keymap("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
keymap("n", "<leader><Left>", "<cmd>tabprevious<CR>", {
   noremap = true,
   silent = true,
   desc = "Previous tab",
})

keymap("n", "<leader><Right>", "<cmd>tabnext<CR>", {
   noremap = true,
   silent = true,
   desc = "Next tab",
})

-- Snacks pickers
keymap("n", "<leader>ff", function()
   Snacks.picker.files()
end, { desc = "Find files" })
keymap("n", "<leader>fg", function()
   Snacks.picker.grep()
end, { desc = "Live grep" })
keymap("n", "<leader>fb", function()
   Snacks.picker.buffers()
end, { desc = "Find buffers" })
keymap("n", "<leader>fh", function()
   Snacks.picker.help()
end, { desc = "Help tags" })

-- Extra useful pickers
keymap("n", "<leader>fr", function()
   Snacks.picker.recent()
end, { desc = "Recent files" })
keymap("n", "<leader>fs", function()
   Snacks.picker.lines()
end, { desc = "Search current buffer" })

-- Custom tab picker using Snacks
keymap("n", "<leader>ft", function()
   local tabs = {}

   for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
      local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
      local names = {}

      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
         local bufnr = vim.api.nvim_win_get_buf(win)
         local name = vim.api.nvim_buf_get_name(bufnr)
         table.insert(names, name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t"))
      end

      table.insert(tabs, {
         text = "Tab " .. tabnr .. ": " .. table.concat(names, " | "),
         tabnr = tabnr,
      })
   end

   Snacks.picker.pick({
      title = "Tabs",
      items = tabs,
      format = "text",
      confirm = function(picker, item)
         picker:close()
         if item then
            vim.cmd(item.tabnr .. "tabnext")
         end
      end,
   })
end, { desc = "Find tabs" })

-- Git
keymap("n", "<leader>gf", function()
   Snacks.picker.git_files()
end, { desc = "Find git files" })
keymap("n", "<leader>gs", function()
   Snacks.picker.git_status()
end, { desc = "Git status" })
keymap("n", "<leader>gb", function()
   Snacks.picker.git_branches()
end, { desc = "Git branches" })
keymap("n", "<leader>gg", function()
   Snacks.lazygit()
end, { desc = "Open LazyGit" })

-- Snacks UX helpers
keymap("n", "<leader>fn", function()
   Snacks.notifier.show_history()
end, { desc = "Notification history" })

keymap("n", "<leader>rn", function()
   Snacks.rename.rename_file()
end, { desc = "Rename file" })

keymap("n", "<leader>zz", function()
   Snacks.zen()
end, { desc = "Toggle zen mode" })

keymap("n", "<leader>.", function()
   Snacks.scratch()
end, { desc = "Toggle scratch buffer" })
return {
   {
      "nvim-lua/plenary.nvim",
      config = function()
         local function venv_python()
            local ok, venv_selector = pcall(require, "venv-selector")

            if ok then
               local selected_python = venv_selector.python()
               if selected_python and vim.fn.executable(selected_python) == 1 then
                  return selected_python
               end
            end

            local cwd = vim.fn.getcwd()
            local py = vim.fn.has("win32") == 1
                and vim.fs.joinpath(cwd, ".venv", "Scripts", "python.exe")
                or vim.fs.joinpath(cwd, ".venv", "bin", "python")

            if vim.fn.executable(py) == 1 then
               return py
            end

            return "python"
         end
         local function venv_scripts()
            local cwd = vim.fn.getcwd()
            return vim.fn.has("win32") == 1
                and vim.fs.joinpath(cwd, ".venv", "Scripts")
                or vim.fs.joinpath(cwd, ".venv", "bin")
         end

         -- Make .venv tools discoverable by Neovim
         local scripts = venv_scripts()
         if vim.fn.isdirectory(scripts) == 1 then
            -- Windows uses semicolon (;), Unix uses colon (:) to separate PATH entries
            local sep = vim.fn.has("win32") == 1 and ";" or ":"
            vim.env.PATH = scripts .. sep .. vim.env.PATH
         end

         vim.api.nvim_create_user_command("PyRun", function()
            vim.cmd("botright split")
            vim.cmd("resize 12")
            -- Wrap path in quotes to handle potential spaces in project directory path
            vim.cmd('terminal "' .. venv_python() .. '" %')
         end, {})

         -- vim.api.nvim_create_user_command("FlaskRun", function()
         -- vim.cmd("botright split")
         -- vim.cmd("resize 12")
         -- vim.cmd('terminal "' .. venv_python() .. '" -m flask run --debug --no-reload')
         -- end, {})

         vim.api.nvim_create_user_command("RuffCheck", function()
            vim.cmd("botright split")
            vim.cmd("resize 12")
            vim.cmd('terminal "' .. venv_python() .. '" -m ruff check .')
         end, {})

         vim.api.nvim_create_user_command("RuffFix", function()
            vim.cmd("botright split")
            vim.cmd("resize 12")
            vim.cmd('terminal "' .. venv_python() .. '" -m ruff check . --fix')
         end, {})

         vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function(event)
               local opts = function(desc)
                  return {
                     buffer = event.buf,
                     noremap = true,
                     silent = true,
                     desc = desc,
                  }
               end

               vim.keymap.set("n", "<leader>pr", "<cmd>PyRun<CR>", opts("Run Python file"))
               -- vim.keymap.set("n", "<leader>pf", "<cmd>FlaskRun<CR>", opts("Run Flask app"))
               vim.keymap.set("n", "<leader>plc", "<cmd>RuffCheck<CR>", opts("Run Ruff check"))
               vim.keymap.set("n", "<leader>pll", "<cmd>RuffFix<CR>", opts("Run Ruff fix all"))

               -- Venv-Selector menu bindings (Moved here!)
               vim.keymap.set("n", "<leader>pvs", "<cmd>VenvSelect<CR>", opts("Select Virtual Env"))
            end,
         })
      end,
   },
}

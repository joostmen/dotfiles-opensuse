local is_windows = vim.fn.has("win32") == 1
local fd_cmd = vim.fn.executable("fd") == 1 and "fd" or "fdfind"

return {
   "linux-cultist/venv-selector.nvim",
   dependencies = {
      "neovim/nvim-lspconfig",
      "folke/snacks.nvim",
      "nvim-lua/plenary.nvim",
   },
   ft = "python",
   cmd = { "VenvSelect", "VenvSelectLog" },
   opts = {
      options = {
         notify_user_on_venv_activation = true,
         set_environment_variables = true,
         activate_venv_in_terminal = true,
         picker = "snacks",
      },

      search = {
         project_venvs = {
            command = is_windows
                  and fd_cmd .. [[ -H -I -a --full-path "Scripts[\\/]python\.exe$" . --color never]]
                  or fd_cmd .. [[ -H -I -a --full-path "bin/python$" . --color never]],
         },
      },
   },
}

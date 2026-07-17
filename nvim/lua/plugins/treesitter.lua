return {
   {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      lazy = false,
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter.configs").setup({
            ensure_installed = {
               "lua",
               "python",
               "markdown",
               "markdown_inline",
               "vim",
               "vimdoc",
               "json",
               "html",
            },
            highlight = {
               enable = true,
            },
            indent = {
               enable = true,
            },
         })
      end,
   },
}

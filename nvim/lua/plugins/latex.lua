return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      vim.g.vimtex_view_general_viewer = "SumatraPDF"
      vim.g.vimtex_view_general_options =
        "-reuse-instance -forward-search @tex @line @pdf"

      vim.g.vimtex_quickfix_mode = 0

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function(event)
          local opts = function(desc)
            return {
              buffer = event.buf,
              noremap = true,
              silent = true,
              desc = desc,
            }
          end

          vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", opts("LaTeX compile"))
          vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", opts("LaTeX view PDF"))
          vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStop<CR>", opts("LaTeX stop compile"))
          vim.keymap.set("n", "<leader>lk", "<cmd>VimtexClean<CR>", opts("LaTeX clean files"))
          vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", opts("LaTeX errors"))
          vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", opts("LaTeX table of contents"))
          vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<CR>", opts("LaTeX VimTeX info"))
        end,
      })
    end,
  },
}
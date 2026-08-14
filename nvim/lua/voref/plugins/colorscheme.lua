return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        indent_blankline = { scope_color = "lavender" },
      },
    })
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,
}

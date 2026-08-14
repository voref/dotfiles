return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*", -- tracks the latest stable release instead of a pinned tag
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      -- Configure Telescope
      telescope.setup({
        defaults = {
          path_display = { "relative" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "ui-select")

      -- Keymaps
      local keymap = vim.keymap.set
      keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      keymap("n", "<leader>fb", builtin.buffers, { desc = "Show buffers" })
      keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
      keymap("n", "<leader>gs", builtin.git_status, { desc = "Git status (changed files)" })

      pcall(function()
        require("which-key").add({
          { "<leader>f", group = "find" },
          { "<leader>g", group = "git" },
        })
      end)
    end,
  },
}

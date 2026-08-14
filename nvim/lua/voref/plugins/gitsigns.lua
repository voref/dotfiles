return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Next git hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Prev git hunk")

				map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
				map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
				map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
				map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, "Diff against previous commit")
				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, "Hunks to quickfix (project)")
				map("n", "<leader>hq", gitsigns.setqflist, "Hunks to quickfix (buffer)")
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle inline blame")
				map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word diff")
				map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
			end,
		})

		pcall(function()
			require("which-key").add({
				{ "<leader>h", group = "git hunk" },
				{ "<leader>t", group = "toggle" },
			})
		end)
	end,
}

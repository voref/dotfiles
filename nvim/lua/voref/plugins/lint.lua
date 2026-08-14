--[[
Flow for adding lint support for a new language:
  1. treesitter parser -> add it to `parsers` below (highlight + indent)
  2. filetype -> add it to `filetypes` below (usually same name as the parser,
     except cases like sh/bash where they differ)
  3. linter -> add an entry to `linters_by_ft` with the nvim-lint adapter name
     (https://github.com/mfussenegger/nvim-lint#available-linters)
  4. install the linter binary yourself (dnf / pip / whatever the tool needs) -
     nothing here installs it for you, there's no mason anymore
]]
local parsers = { "lua", "python", "terraform", "yaml", "bash", "markdown" }
local filetypes = { "lua", "python", "terraform", "yaml", "sh", "markdown" } -- "sh" here, "bash" above: parser name != filetype name
local linters_by_ft = { -- these need to be installed from your package manager / pip / npm
	python = { "ruff" },
	yaml = { "yamllint" },
	["yaml.ansible"] = { "ansible_lint" },
	terraform = { "terraform_validate" },
	sh = { "shellcheck" },
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- this plugin doesn't support lazy-loading
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = linters_by_ft

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})

			-- Global mode: :Ansible / :Yaml decide how EVERY yaml buffer (current and future) gets
			-- treated from then on - not just the one you're in. Persists until you switch again.
			vim.g.ansible_mode = false

			local function apply_yaml_mode(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft ~= "yaml" and ft ~= "yaml.ansible" then
					return
				end
				local target = vim.g.ansible_mode and "yaml.ansible" or "yaml"
				if ft ~= target then
					vim.bo[bufnr].filetype = target
				end
			end

			-- catches files opened AFTER switching mode
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "yaml", "yaml.ansible" },
				callback = function(args)
					apply_yaml_mode(args.buf)
				end,
			})

			local function switch_yaml_mode(ansible)
				vim.g.ansible_mode = ansible
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(buf) then
						apply_yaml_mode(buf)
						vim.diagnostic.reset(nil, buf)
						vim.api.nvim_buf_call(buf, function()
							require("lint").try_lint()
						end)
					end
				end
			end

			vim.api.nvim_create_user_command("Ansible", function()
				switch_yaml_mode(true)
			end, { desc = "Treat all yaml buffers as Ansible from now on" })

			vim.api.nvim_create_user_command("Yaml", function()
				switch_yaml_mode(false)
			end, { desc = "Treat all yaml buffers as plain YAML from now on" })
		end,
	},
}

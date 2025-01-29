return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		-- vim.g.rustaceanvim = {
		-- 	-- Plugin configuration
		-- 	tools = {
		-- 	},
		-- 	-- LSP configuration
		-- 	server = {
		-- 		on_attach = function(client, bufnr)
		-- 			-- you can also put keymaps in here
		-- 		end,
		-- 		default_settings = {
		-- 			-- rust-analyzer language server configuration
		-- 			['rust-analyzer'] = {
		-- 			},
		-- 		},
		-- 	},
		-- 	-- DAP configuration
		-- 	dap = {
		-- 	},
		-- }
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>rr", "<cmd>RustLsp! runnables<cr>", { desc = "Run program" })
		keymap.set("n", "<leader>rR", "<cmd>RustLsp runnables<cr>", { desc = "Run program" })

		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
	end,
}

return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			options = {
				mode = "buffers",
				themable = true,
				numbers = "ordinal",
				close_command = "bdelete! %d",
				indicator = {
					icon = "▕",
					style = "icon",
				},
				buffer_close_icon = "",
				modified_icon = " ",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "{" .. count .. "}"
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "  Files",
						text_align = "center",
						highlight = "NvimPyTab",
						separator = true,
					},
					{
						filetype = "termim",
						text = "  Files",
						text_align = "center",
						separator = true,
					},
					{
						filetype = "Outline",
						text = " Symbols",
						highlight = "NvimPyTab",
						text_align = "center",
						separator = true,
					},
					{
						filetype = "undotree",
						text = "  Undo",
						highlight = "NvimPyTab",
						text_align = "center",
						separator = true,
					},
					{
						filetype = "dap-repl",
						text = "  Debugging",
						highlight = "NvimPyTab",
						text_align = "center",
						separator = true,
					},
				},
				color_icons = true,
				get_element_icon = function(element)
					-- element consists of {filetype: string, path: string, extension: string, directory: string}
					-- This can be used to change how bufferline fetches the icon
					-- for an element e.g. a buffer or a tab.
					-- e.g.
					local icon, hl =
						require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
					return icon, hl
				end,
				separator_style = "slant",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		},
	},
}

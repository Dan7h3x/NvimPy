local fzf_lua = require("fzf-lua")

local img_prev_bin = vim.fn.executable("ueberzug") == 1 and { "ueberzug" }
	or vim.fn.executable("chafa") == 1 and { "chafa" }
	or vim.fn.executable("viu") == 1 and { "viu", "-b" }
	or nil

-- return first matching highlight or nil
local function hl_match(t)
	for _, h in ipairs(t) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = h, link = false })
		if ok and type(hl) == "table" and (hl.fg or hl.bg) then
			return h
		end
	end
end

local symbol_hls = nil -- will be generated by symbol_hl fn
local symbol_icons = {
	File = "",
	Module = "",
	Namespace = "󰅩",
	Package = "",
	Class = "󰌗",
	Method = "󰊕",
	Property = "",
	Field = "",
	Constructor = "",
	Enum = "",
	Interface = "󰠱",
	Function = "󰊕",
	Variable = "󰀫",
	Constant = "󰏿",
	String = "󰊄",
	Number = "󰎠",
	Boolean = "󰝖",
	Array = "",
	Object = "󰜫",
	Key = "󰌆",
	Null = "Ø",
	EnumMember = "",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

local symbol_hl = function(s)
	if not symbol_hls then
		symbol_hls = {}
		for k, _ in pairs(symbol_icons) do
			symbol_hls[k] = hl_match({ "CmpItemKind" .. k, "@" .. k:lower(), k })
		end
		-- fallback
		symbol_hls = vim.tbl_extend("keep", symbol_hls, {
			Object = "Label",
			Key = "Keyword",
			Array = "Directory",
			Null = "Float",
			Package = "@function",
		})
	end
	return symbol_hls[s]
end

local default_opts = {
	"default-title",
	-- nvim_freeze_workaround = 1,
	-- debug_tracelog = "~/fzf-lua-trace.log",
	-- fzf_opts = { ["--info"] = "default" },
	fzf_colors = function()
		return vim.g.colors_name == "nightfly"
				and {
					["info"] = { "fg", { "NightflyPeach" } },
					["scrollbar"] = { "fg", { "NightflyPeach" } },
					["hl+"] = { "fg", { "NightflyPeach", "String" } },
				}
			or {
				-- Set to `-1` to use neovim fg/bg, from `man fzf`:
				--   Default terminal foreground/background color
				--   (or the original color of the text)
				-- ["fg"] = { "fg", "Comment" },
				["bg"] = "-1",
				["hl"] = { "fg", { "NightflyPeach", "String" } },
				["fg+"] = { "fg", "Normal" },
				["bg+"] = { "bg", { "Visual" } },
				["hl+"] = { "fg", { "NightflyPeach", "String" } },
				["info"] = { "fg", { "NightflyPeach", "WarningMsg" } },
				-- ["prompt"] = { "fg", "SpecialKey" },
				["pointer"] = { "fg", "DiagnosticError" },
				["marker"] = { "fg", "DiagnosticError" },
				["spinner"] = { "fg", "Label" },
				["header"] = { "fg", "Comment" },
				["gutter"] = "-1",
				["scrollbar"] = { "fg", { "NightflyPeach", "WarningMsg" } },
			}
	end,
	-- winopts_fn = function()
	--   -- local split = "botright new" -- use for split under **all** windows
	--   local split = "belowright new"  -- use for split under current windows
	--   local height = math.floor(vim.o.lines * 0.3)
	--   return { split = split .. " | resize " .. tostring(height) }
	-- end,
	winopts = {
		-- split   = "belowright new",
		-- split   = "belowright vnew",
		-- split   = "aboveleft new",
		-- split   = "aboveleft vnew",
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.55,
		-- border = { {'╭', 'IncSearch'}, {'─', 'IncSearch'},
		-- {'╮', 'IncSearch'}, '│', '╯', '─', '╰', '│' },
		preview = {
			layout = "flex",
			-- vertical     = "down:50%",
			-- vertical     = "up:50%",
			-- horizontal   = "right:55%",
			-- horizontal   = "left:60%",
			flip_columns = 130,
			scrollbar = "float",
			-- scrolloff        = '-1',
			-- scrollchars      = {'█', '░' },
		},
		on_create = function()
			-- disable miniindentscope
			vim.b.miniindentscope_disable = true
		end,
	},
	hls = function()
		return {
			border = hl_match({ "FloatBorder", "LineNr" }),
			preview_border = hl_match({ "FloatBorder", "LineNr" }),
			cursorline = "Visual",
			cursorlinenr = "Visual",
			dir_icon = hl_match({ "NightflyGreyBlue", "Directory" }),
		}
	end,
	previewers = {
		bat = { theme = "Coldark-Dark", args = "--color=always --style=default" },
		builtin = {
			title_fnamemodify = function(s)
				return s
			end,
			ueberzug_scaler = "cover",
			extensions = {
				["gif"] = img_prev_bin,
				["png"] = img_prev_bin,
				["jpg"] = img_prev_bin,
				["jpeg"] = img_prev_bin,
				["svg"] = { "chafa" },
			},
		},
	},
	actions = {
		files = {
			["default"] = fzf_lua.actions.file_edit_or_qf,
			["ctrl-l"] = fzf_lua.actions.arg_add,
			["ctrl-s"] = fzf_lua.actions.file_split,
			["ctrl-v"] = fzf_lua.actions.file_vsplit,
			["ctrl-t"] = fzf_lua.actions.file_tabedit,
			["ctrl-q"] = fzf_lua.actions.file_sel_to_qf,
			["alt-q"] = fzf_lua.actions.file_sel_to_ll,
		},
	},
	-- all providers inherit from defaults, easier than to set this individually
	-- for git diff, commits and bcommits (we have an override for lsp.code_actions)
	defaults = { formatter = { "path.dirname_first", v = 2 } },
	buffers = { no_action_zz = true },
	files = {
		-- uncomment to override .gitignore
		-- fd_opts  = "--no-ignore --color=never --type f --hidden --follow --exclude .git",
		fzf_opts = { ["--tiebreak"] = "end" },
	},
	grep = {
		debug = false,
		rg_glob = true,
		rg_opts = [[--hidden --column --line-number --no-heading]] .. [[ --color=always --smart-case -g "!.git" -e]],
		fzf_opts = {
			["--history"] = fzf_lua.path.join({ vim.fn.stdpath("data"), "fzf_search_hist" }),
		},
		actions = {
			["ctrl-r"] = { fzf_lua.actions.grep_lgrep },
			["ctrl-g"] = { fzf_lua.actions.toggle_ignore },
		},
	},
	lines = {
		actions = {
			["ctrl-q"] = fzf_lua.actions.buf_sel_to_qf,
			["alt-q"] = fzf_lua.actions.buf_sel_to_ll,
		},
	},
	blines = {
		actions = {
			["ctrl-q"] = fzf_lua.actions.buf_sel_to_qf,
			["alt-q"] = fzf_lua.actions.buf_sel_to_ll,
		},
	},
	tags = { actions = { ["ctrl-g"] = false, ["ctrl-r"] = { fzf_lua.actions.grep_lgrep } } },
	btags = { actions = { ["ctrl-g"] = false, ["ctrl-r"] = false } },
	git = {
		status = {
			winopts = {
				preview = { vertical = "down:70%", horizontal = "right:70%" },
			},
		},
		commits = { winopts = { preview = { vertical = "down:60%" } } },
		bcommits = { winopts = { preview = { vertical = "down:60%" } } },
		branches = {
			-- cmd_add = { "git", "checkout", "-b" },
			cmd_del = { "git", "branch", "--delete", "--force" },
			winopts = {
				preview = { vertical = "down:75%", horizontal = "right:75%" },
			},
		},
	},
	lsp = {
		finder = {
			providers = {
				{ "definitions", prefix = fzf_lua.utils.ansi_codes.green("def ") },
				{ "declarations", prefix = fzf_lua.utils.ansi_codes.magenta("decl") },
				{ "implementations", prefix = fzf_lua.utils.ansi_codes.green("impl") },
				{ "typedefs", prefix = fzf_lua.utils.ansi_codes.red("tdef") },
				{ "references", prefix = fzf_lua.utils.ansi_codes.blue("ref ") },
				{ "incoming_calls", prefix = fzf_lua.utils.ansi_codes.cyan("in  ") },
				{ "outgoing_calls", prefix = fzf_lua.utils.ansi_codes.yellow("out ") },
			},
		},
		symbols = {
			path_shorten = 1,
			symbol_icons = symbol_icons,
			symbol_hl = symbol_hl,
			actions = { ["ctrl-g"] = false, ["ctrl-r"] = { fzf_lua.actions.sym_lsym } },
		},
		code_actions = {
			winopts = {
				relative = "cursor",
				row = 1,
				col = 0,
				height = 0.4,
				preview = { vertical = "down:70%" },
			},
			previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
			preview_pager = "delta --width=$COLUMNS --hunk-header-style='omit' --file-style='omit'",
		},
	},
	diagnostics = { file_icons = false, path_shorten = 1 },
	dir_icon = "",
}

return {
	setup = function()
		-- NOT NEEDED since fzf-lua commit 604eadf
		-- custom devicons setup file to be loaded when `multiprocess = true`
		-- fzf_lua.config._devicons_setup = "~/.config/nvim/lua/plugins/devicons/setup.lua"

		fzf_lua.setup(default_opts)

		vim.api.nvim_create_augroup("FzfLuaColor", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				symbol_hls = nil
			end,
			group = "FzfLuaColor",
		})
	end,
}
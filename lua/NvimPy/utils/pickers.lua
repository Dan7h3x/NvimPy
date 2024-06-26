---@class NvimPy.utils.pickers
---@overload fun(command:string, opts?:NvimPy.utils.pickers.Opts): fun()
local lazytools = require("lazy.core.util")
local M = setmetatable({}, {
	__call = function(m, ...)
		return m.wrap(...)
	end,
})

---@class NvimPy.utils.pickers.Opts: table
---@field root? boolean
---@field cwd? string
---@field buf? number
---@field show_untracked? boolean

---@class LazyPicker
---@field name string
---@field open fun(command:string, opts?:NvimPy.utils.picker.Opts)
---@field commands table<string, string>

---@type LazyPicker?
M.picker = nil

---@type table<string, string>
M.commands = {
	files = "find_files",
}

---@param picker LazyPicker
function M.register(picker)
	-- this only happens when using :LazyExtras
	-- so allow to get the full spec
	if vim.v.vim_did_enter == 1 then
		return true
	end
	if M.picker and M.picker.name ~= picker.name then
		lazytools.warn(
			"`NvimPy.pick`: picker already set to `"
				.. M.picker.name
				.. "`,\nignoring new picker `"
				.. picker.name
				.. "`"
		)
		return false
	end
	M.picker = picker
	return true
end

---@param command? string
---@param opts? NvimPy.utils.pickers.Opts
function M.open(command, opts)
	if not M.picker then
		return lazytools.error("NvimPy.pick: picker not set")
	end

	command = command or "auto"
	opts = opts or {}

	opts = vim.deepcopy(opts)

	if type(opts.cwd) == "boolean" then
		lazytools.warn("NvimPy.pick: opts.cwd should be a string or nil")
		opts.cwd = nil
	end

	-- if not opts.cwd and opts.root ~= false then
	--   opts.cwd = require("NvimPy.utils.root").root({ buf = opts.buf })
	-- end

	local cwd = opts.cwd or vim.uv.cwd()
	if command == "auto" then
		command = "files"
		if
			vim.uv.fs_stat(cwd .. "/.git")
			and not vim.uv.fs_stat(cwd .. "/.ignore")
			and not vim.uv.fs_stat(cwd .. "/.rgignore")
		then
			command = "git_files"
			opts.show_untracked = opts.show_untracked ~= false
		end
	end
	command = M.picker.commands[command] or command
	M.picker.open(command, opts)
end

---@param command? string
---@param opts? NvimPy.utils.pickers.Opts
function M.wrap(command, opts)
	opts = opts or {}
	return function()
		M.open(command, vim.deepcopy(opts))
	end
end

function M.config_files()
	return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end

return M

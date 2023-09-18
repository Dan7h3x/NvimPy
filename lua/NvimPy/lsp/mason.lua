local servers = {
	-- "sumneko_lua",
	"cssls",
	-- "html",
	-- "tsserver",
	"lua_ls",
	"bashls",
	"jsonls",
	"yamlls",
	"pyright",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 6,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("NvimPy.lsp.handlers").on_attach,
		capabilities = require("NvimPy.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "NvimPy.lsp.settings" .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

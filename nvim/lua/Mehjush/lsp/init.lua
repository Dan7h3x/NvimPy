local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "Mehjush.lsp.mason"
require("Mehjush.lsp.handlers").setup()
require "Mehjush.lsp.null-ls"

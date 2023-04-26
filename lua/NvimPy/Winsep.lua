require("colorful-winsep").setup({
  -- highlight for Window separator
  highlight = {
    bg = "#000000",
    fg = "#000aff",
  },
  -- timer refresh rate
  interval = 30,
  -- This plugin will not be activated for filetype in the following table.
  no_exec_files = { "lazy", "TelescopePrompt", "mason", "CompetiTest", "NeoTree" },
  -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
  symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
  close_event = function()
    -- Executed after closing the window separator
  end,
  create_event = function()
    -- Executed after creating the window separator
  end,
})

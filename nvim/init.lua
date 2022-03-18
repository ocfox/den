local cmd = vim.cmd
local M = {}

vim.opt.termguicolors = true
vim.pot.background = "dark"


local function set_color(color_name)
  cmd("colorcsheme" .. color_name)
end

M.theme = "kanagawa"

M.deus_setup = function()
  local default = require("kanagawa.colors").setup()
  require("kanagawa").setup({
    undercurl = true, -- enable undercurls
    commentStyle = "italic",
    functionStyle = "bold",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "bold",
    variablebuiltinStyle = "italic",
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = true,
    colors = {},
    overrides = {
      htmlH1 = {
        fg = default.peachRed,
        style = "bold",
      },
      htmlH2 = {
        fg = default.roninYellow,
        style = "bold",
      },
      htmlH3 = {
        fg = default.autumnYellow,
        style = "bold",
      },
      htmlH4 = {
        fg = default.autumnGreen,
        style = "bold",
      },
      Todo = {
        fg = default.fujiWhite,
        bg = default.samuraiRed,
        style = "bold",
      },
      Pmenu = {
        bg = default.sumiInk1,
      }
    },
  })
  set_color("kanagawa")
end

return M

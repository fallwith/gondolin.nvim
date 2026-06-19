-----------------------------------------------------------------------------
--- Gondolin Dark
--- Upstream: https://github.com/wunki/gondolin.nvim/blob/main/extras/wezterm_tabline/gondolin-dark.lua
--- URL: https://github.com/michaelbrusegard/tabline.wez
-----------------------------------------------------------------------------

local M = {}

M = {
  normal_mode = {
    a = { fg = "#1a1d23", bg = "#83AEF8" },
    b = { fg = "#83AEF8", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  copy_mode = {
    a = { fg = "#1a1d23", bg = "#B9EC86" },
    b = { fg = "#B9EC86", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  search_mode = {
    a = { fg = "#1a1d23", bg = "#CC95FF" },
    b = { fg = "#CC95FF", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  window_mode = {
    a = { fg = "#1a1d23", bg = "#83AEF8" },
    b = { fg = "#83AEF8", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  resize_mode = {
    a = { fg = "#1a1d23", bg = "#FFBE78" },
    b = { fg = "#FFBE78", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  tab_mode = {
    a = { fg = "#1a1d23", bg = "#83AEF8" },
    b = { fg = "#83AEF8", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  default_mode = {
    a = { fg = "#1a1d23", bg = "#FF7A77" },
    b = { fg = "#FF7A77", bg = "#1a1d23" },
    c = { fg = "#A2AEC0", bg = "#0d0f13" },
  },
  tab = {
    active = { fg = '#83AEF8', bg = '#080A0D', bold = true },
    inactive = { fg = '#A2AEC0', bg = '#0d0f13' },
    inactive_hover = { fg = '#CC95FF', bg = '#080A0D' },
  },
  ansi = {
    "#080A0D",
    "#FF7A77",
    "#B9EC86",
    "#FFE878",
    "#83AEF8",
    "#FF8DFF",
    "#83AEF8",
    "#D6DAE7",
  },
  brights = {
    "#505668",
    "#FF7774",
    "#B9FF6C",
    "#FFE878",
    "#71FEFF",
    "#FF8DFF",
    "#71FFDF",
    "#ffffff",
  },
}

return M

-----------------------------------------------------------------------------
--- Gondolin Light
--- Upstream: https://github.com/wunki/gondolin.nvim/blob/main/extras/wezterm_tabline/gondolin-light.lua
--- URL: https://github.com/michaelbrusegard/tabline.wez
-----------------------------------------------------------------------------

local M = {}

M = {
  normal_mode = {
    a = { fg = "#f8f1e7", bg = "#46778d" },
    b = { fg = "#46778d", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  copy_mode = {
    a = { fg = "#f8f1e7", bg = "#477f5e" },
    b = { fg = "#477f5e", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  search_mode = {
    a = { fg = "#f8f1e7", bg = "#85647f" },
    b = { fg = "#85647f", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  window_mode = {
    a = { fg = "#f8f1e7", bg = "#637827" },
    b = { fg = "#637827", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  resize_mode = {
    a = { fg = "#f8f1e7", bg = "#aa5f1b" },
    b = { fg = "#aa5f1b", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  tab_mode = {
    a = { fg = "#f8f1e7", bg = "#46778d" },
    b = { fg = "#46778d", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  default_mode = {
    a = { fg = "#f8f1e7", bg = "#aa544d" },
    b = { fg = "#aa544d", bg = "#f8f1e7" },
    c = { fg = "#829181", bg = "#f8f1e7" },
  },
  tab = {
    active = { fg = '#46778d', bg = '#f4efe6', bold = true },
    inactive = { fg = '#829181', bg = '#f8f1e7' },
    inactive_hover = { fg = '#aa544d', bg = '#f4efe6' },
  },
  ansi = {
    "#5c6a72",
    "#aa544d",
    "#637827",
    "#aa5f1b",
    "#46778d",
    "#85647f",
    "#477f5e",
    "#f4efe6",
  },
  brights = {
    "#748278",
    "#bb625b",
    "#718735",
    "#bd6e22",
    "#53879e",
    "#95728e",
    "#548f6c",
    "#fffaf3",
  },
}

return M

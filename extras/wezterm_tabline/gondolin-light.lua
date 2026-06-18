-----------------------------------------------------------------------------
--- Gondolin Light
--- Upstream: https://github.com/wunki/gondolin.nvim/main/extras/wezterm_tabline/gondolin-light.lua
--- URL: https://github.com/michaelbrusegard/tabline.wez
-----------------------------------------------------------------------------

local M = {}

M = {
  normal_mode = {
    a = { fg = "#eee4d6", bg = "#77593a" },
    b = { fg = "#77593a", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  copy_mode = {
    a = { fg = "#eee4d6", bg = "#3f8d58" },
    b = { fg = "#3f8d58", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  search_mode = {
    a = { fg = "#eee4d6", bg = "#7d5bc4" },
    b = { fg = "#7d5bc4", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  window_mode = {
    a = { fg = "#eee4d6", bg = "#77593a" },
    b = { fg = "#77593a", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  resize_mode = {
    a = { fg = "#eee4d6", bg = "#9f6c1f" },
    b = { fg = "#9f6c1f", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  tab_mode = {
    a = { fg = "#eee4d6", bg = "#4a6890" },
    b = { fg = "#4a6890", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  default_mode = {
    a = { fg = "#eee4d6", bg = "#b4545b" },
    b = { fg = "#b4545b", bg = "#eee4d6" },
    c = { fg = "#786753", bg = "#f8f1e7" },
  },
  tab = {
    active = { fg = '#77593a', bg = '#f4efe6', bold = true },
    inactive = { fg = '#786753', bg = '#f8f1e7' },
    inactive_hover = { fg = '#7b5a35', bg = '#f4efe6' },
  },
  ansi = {
    "#2f2417",
    "#b4545b",
    "#3f8d58",
    "#9f6c1f",
    "#4a6890",
    "#7d5bc4",
    "#356b7f",
    "#f4efe6",
  },
  brights = {
    "#786753",
    "#c96369",
    "#4d9d67",
    "#b77d2c",
    "#5778a5",
    "#8f6dd6",
    "#427f95",
    "#fffaf3",
  },
}

return M

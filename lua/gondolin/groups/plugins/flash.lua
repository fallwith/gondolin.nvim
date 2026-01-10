local M = {}

---@param colors GondolinColors
---@param opts GondolinConfig
function M.get(colors, opts)
	local theme = colors.theme

	return {
		FlashBackdrop = { fg = theme.syn.comment },
		FlashMatch = { link = "Search" },
		FlashCurrent = { link = "Search" },
		FlashLabel = { fg = theme.ui.picker, bold = true },
	}
end

return M

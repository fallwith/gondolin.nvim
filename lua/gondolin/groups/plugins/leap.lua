local M = {}

---@param colors GondolinColors
---@param opts GondolinConfig
function M.get(colors, opts)
	local theme = colors.theme

	return {
		LeapBackdrop = { fg = theme.syn.comment },
		LeapMatch = { link = "Search" },
		LeapLabel = { fg = theme.ui.picker, bold = true },
	}
end

return M

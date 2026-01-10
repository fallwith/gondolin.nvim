local M = {}

---@param colors GondolinColors
---@param opts GondolinConfig
function M.get(colors, opts)
	local theme = colors.theme

	return {
		MCPHubText = { link = "NormalFloat" },
		MCPHubLink = { link = "Underlined" },
	}
end

return M

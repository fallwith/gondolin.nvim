local M = {}

---@param colors GondolinColors
---@param opts? GondolinConfig
function M.setup(colors, opts)
	opts = opts or require("gondolin.config").options
	local theme = colors.theme

	return {
		-- zsh
		zshVariable = { link = "@variable" },
		zshFunction = { link = "@function" },
		zshOperator = { link = "@operator" },

		-- terraform
		tfQuotes = { link = "String" },
	}
end

return M

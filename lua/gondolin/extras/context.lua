local M = {}

local function upstream_url(filename)
	return "https://github.com/wunki/gondolin.nvim/blob/main/extras/" .. filename
end

---@param extra string
---@param info table
---@param suffix string
---@return string
function M.filename(extra, info, suffix)
	local filename = extra
		.. (info.subdir and "/" .. info.subdir .. "/" or "")
		.. "/gondolin"
		.. (info.sep or "-")
		.. suffix
		.. "."
		.. info.ext

	return filename:gsub("%.$", "")
end

---@param data table
---@param info table
---@param filename string
---@param name string
---@param style_name string
---@param theme? string
---@return table
function M.with_metadata(data, info, filename, name, style_name, theme)
	local context = vim.deepcopy(data)
	context["_url"] = info.url
	context["_upstream_url"] = upstream_url(filename)
	context["_package_name"] = "Gondolin"
	context["_style_name"] = style_name
	context["_name"] = name
	context["_theme"] = theme
	return context
end

---@param extra string
---@param output any
---@return string
function M.assert_rendered(extra, output)
	assert(type(output) == "string", "extra " .. extra .. " did not return a string")

	for unresolved in output:gmatch("%${([^}]+)}") do
		if not unresolved:match("^[A-Z][A-Z0-9_]*$") then
			error("extra " .. extra .. " has unresolved template value: ${" .. unresolved .. "}")
		end
	end

	return output
end

return M

local M = {}

local kind_links = {
	Method = "@function.method",
	Function = "Function",
	Constructor = "@constructor",
	Field = "@variable.member",
	Variable = "@variable",
	Class = "Type",
	Interface = "Type",
	Module = "@module",
	Property = "@property",
	Unit = "Number",
	Value = "String",
	Enum = "Type",
	Keyword = "Keyword",
	Snippet = "Special",
	Color = "Special",
	File = "Directory",
	Reference = "Special",
	Folder = "Directory",
	EnumMember = "Constant",
	Constant = "Constant",
	Struct = "Type",
	Event = "Type",
	Operator = "Operator",
	TypeParameter = "Type",
	Copilot = "String",
}

---@param prefix string
---@return table<string, vim.api.keyset.highlight>
function M.kind_links(prefix)
	local groups = {}
	for kind, link in pairs(kind_links) do
		groups[prefix .. kind] = { link = link }
	end
	return groups
end

return M

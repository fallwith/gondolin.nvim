local M = {}

function M.get(colors, opts)
	local theme = colors.theme

	return vim.tbl_extend("force", {
		CmpCompletion = { link = "Pmenu" },
		CmpCompletionSel = { link = "PmenuSel" },
		CmpCompletionBorder = { fg = theme.ui.bg_search, bg = theme.ui.pmenu.bg },
		CmpCompletionThumb = { bg = theme.ui.scrollbar },
		CmpCompletionSbar = { bg = theme.ui.fg },
		CmpDocumentation = { link = "NormalFloat" },
		CmpDocumentationBorder = { link = "FloatBorder" },
		CmpItemAbbr = { fg = theme.ui.pmenu.fg },
		CmpItemAbbrDeprecated = { fg = theme.syn.comment, strikethrough = true },
		CmpItemAbbrMatch = { fg = theme.syn.fun },
		CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
		CmpItemMenu = { fg = theme.ui.fg_dimmer },
		CmpGhostText = { fg = theme.syn.comment },

		CmpItemKindDefault = { fg = theme.ui.fg_dimmer },
		CmpItemKindText = { fg = theme.ui.fg },
	}, require("gondolin.groups.completion").kind_links("CmpItemKind"))
end

return M

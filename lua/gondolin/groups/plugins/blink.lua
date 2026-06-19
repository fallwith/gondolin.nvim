local M = {}

function M.get(colors, opts)
	local theme = colors.theme

	return vim.tbl_extend("force", {
		BlinkCmpMenu = { link = "Pmenu" },
		BlinkCmpMenuBorder = { fg = theme.ui.pmenu.fg_border, bg = theme.ui.pmenu.bg_border },
		BlinkCmpMenuSelection = { link = "PmenuSel" },
		BlinkCmpScrollBarThumb = { bg = theme.ui.pmenu.bg_thumb },
		BlinkCmpScrollBarGutter = { bg = theme.ui.fg },
		BlinkCmpLabel = { fg = theme.ui.pmenu.fg },
		BlinkCmpLabelMatch = { fg = theme.syn.fun },
		BlinkCmpLabelDetail = { link = "NonText" },
		BlinkCmpLabelDescription = { link = "NonText" },
		BlinkCmpLabelDeprecated = { fg = theme.syn.comment, strikethrough = true },
		BlinkCmpSource = { link = "String" },
		BlinkCmpGhostText = { fg = theme.syn.comment },
		BlinkCmpDoc = { link = "NormalFloat" },
		BlinkCmpDocBorder = { link = "FloatBorder" },
		BlinkCmpDocSeparator = { fg = theme.ui.win_separator },
		BlinkCmpDocCursorLine = { link = "CursorLine" },
		BlinkCmpSignatureHelp = { link = "NormalFloat" },
		BlinkCmpSignatureHelpBorder = { fg = theme.ui.bg_search, bg = theme.ui.pmenu.bg },
		BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },

		BlinkCmpKind = { fg = theme.accent.accent4 },
		BlinkCmpKindText = { fg = theme.ui.fg },
	}, require("gondolin.groups.completion").kind_links("BlinkCmpKind"))
end

return M

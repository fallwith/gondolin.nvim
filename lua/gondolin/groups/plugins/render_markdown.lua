local color = require("gondolin.lib.color")

local M = {}

function M.get(colors, opts)
	local theme = colors.theme

	return {
		RenderMarkdownH1 = { fg = theme.rainbow.rainbow1 },
		RenderMarkdownH2 = { fg = theme.rainbow.rainbow2 },
		RenderMarkdownH3 = { fg = theme.rainbow.rainbow3 },
		RenderMarkdownH4 = { fg = theme.rainbow.rainbow4 },
		RenderMarkdownH5 = { fg = theme.rainbow.rainbow5 },
		RenderMarkdownH6 = { fg = theme.rainbow.rainbow6 },

		RenderMarkdownH1Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
		RenderMarkdownH2Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
		RenderMarkdownH3Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
		RenderMarkdownH4Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
		RenderMarkdownH5Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
		RenderMarkdownH6Bg = {
			fg = theme.ui.fg,
			bg = colors.palette.bg2,
			bold = true,
		},
	}
end

return M

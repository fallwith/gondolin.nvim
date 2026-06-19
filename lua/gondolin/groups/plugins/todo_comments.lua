local color = require("gondolin.lib.color")

local M = {}

function M.get(colors, opts)
	local theme = colors.theme

	-- Blend keyword colors with comment color for a muted appearance
	local function muted(hex)
		return color(hex):blend(theme.syn.comment, 0.5):to_hex()
	end

	local kw = {
		FIX = muted(theme.diag.error),
		TODO = muted(theme.diag.info),
		HACK = muted(theme.diag.warning),
		WARN = muted(theme.diag.warning),
		PERF = muted(theme.diag.hint),
		NOTE = muted(theme.diag.ok),
		TEST = muted(theme.accent.accent1),
	}

	return {
		-- Background highlights (used for wide/bg keyword style)
		TodoBgFIX = { fg = theme.ui.bg, bg = kw.FIX, bold = true },
		TodoBgTODO = { fg = theme.ui.bg, bg = kw.TODO, bold = true },
		TodoBgHACK = { fg = theme.ui.bg, bg = kw.HACK, bold = true },
		TodoBgWARN = { fg = theme.ui.bg, bg = kw.WARN, bold = true },
		TodoBgPERF = { fg = theme.ui.bg, bg = kw.PERF, bold = true },
		TodoBgNOTE = { fg = theme.ui.bg, bg = kw.NOTE, bold = true },
		TodoBgTEST = { fg = theme.ui.bg, bg = kw.TEST, bold = true },

		-- Foreground highlights (used for fg keyword style and after text)
		TodoFgFIX = { fg = kw.FIX },
		TodoFgTODO = { fg = kw.TODO },
		TodoFgHACK = { fg = kw.HACK },
		TodoFgWARN = { fg = kw.WARN },
		TodoFgPERF = { fg = kw.PERF },
		TodoFgNOTE = { fg = kw.NOTE },
		TodoFgTEST = { fg = kw.TEST },

		-- Sign column highlights
		TodoSignFIX = { fg = kw.FIX },
		TodoSignTODO = { fg = kw.TODO },
		TodoSignHACK = { fg = kw.HACK },
		TodoSignWARN = { fg = kw.WARN },
		TodoSignPERF = { fg = kw.PERF },
		TodoSignNOTE = { fg = kw.NOTE },
		TodoSignTEST = { fg = kw.TEST },
	}
end

return M

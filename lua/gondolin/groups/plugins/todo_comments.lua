local color = require("gondolin.lib.color")

local M = {}

function M.get(colors, opts)
	local palette = colors.palette

	-- Blend keyword colors with comment color for a muted appearance
	local function muted(hex)
		return color(hex):blend(palette.comment, 0.5):to_hex()
	end

	local kw = {
		FIX = muted(palette.error),
		TODO = muted(palette.info),
		HACK = muted(palette.warning),
		WARN = muted(palette.warning),
		PERF = muted(palette.hint),
		NOTE = muted(palette.success),
		TEST = muted(palette.accent),
	}

	return {
		-- Background highlights (used for wide/bg keyword style)
		TodoBgFIX = { fg = palette.bg1, bg = kw.FIX, bold = true },
		TodoBgTODO = { fg = palette.bg1, bg = kw.TODO, bold = true },
		TodoBgHACK = { fg = palette.bg1, bg = kw.HACK, bold = true },
		TodoBgWARN = { fg = palette.bg1, bg = kw.WARN, bold = true },
		TodoBgPERF = { fg = palette.bg1, bg = kw.PERF, bold = true },
		TodoBgNOTE = { fg = palette.bg1, bg = kw.NOTE, bold = true },
		TodoBgTEST = { fg = palette.bg1, bg = kw.TEST, bold = true },

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

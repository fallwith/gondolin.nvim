local util = require("gondolin.lib.util")

local M = {}

--- Convert a "#RRGGBB" hex string to a Blink/hterm "rgba(r,g,b,a)" string.
---@param hex string
---@param alpha string
---@return string
local function hex_to_rgba(hex, alpha)
	local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
	if not r then
		return hex
	end
	return string.format("rgba(%d,%d,%d,%s)", tonumber(r, 16), tonumber(g, 16), tonumber(b, 16), alpha)
end

--- @param colors ThemeColors
function M.generate(colors)
	colors = vim.deepcopy(colors)
	-- hterm renders the cursor as a solid block; use 50% alpha (like the
	-- upstream themes) so the glyph under the cursor stays visible.
	colors.ui.cursor = hex_to_rgba(colors.ui.cursor, "0.5")

	local blink = util.template(
		[[
/*
 * ${_style_name}
 * Upstream: ${_upstream_url}
 * URL: ${_url}
 *
 * Add this theme in Blink.app: Settings -> Appearance -> Add a new theme,
 * then paste the contents of this file.
 */

t.prefs_.set('color-palette-overrides', [
    // normal
    "${term.black}",
    "${term.red}",
    "${term.green}",
    "${term.yellow}",
    "${term.blue}",
    "${term.magenta}",
    "${term.cyan}",
    "${term.white}",
    // bright
    "${term.black_bright}",
    "${term.red_bright}",
    "${term.green_bright}",
    "${term.yellow_bright}",
    "${term.blue_bright}",
    "${term.magenta_bright}",
    "${term.cyan_bright}",
    "${term.white_bright}"
]);

t.prefs_.set('foreground-color', "${ui.fg}");
t.prefs_.set('background-color', "${ui.bg}");
t.prefs_.set('cursor-color', '${ui.cursor}');
]],
		colors
	)
	return blink
end

return M

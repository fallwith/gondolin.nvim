local util = require("gondolin.lib.util")

local M = {}

--- @param colors ThemeColors
function M.generate(colors)
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
t.prefs_.set('cursor-color', "${ui.cursor}");
]],
		colors
	)
	return blink
end

return M

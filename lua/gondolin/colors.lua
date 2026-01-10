local color = require("gondolin.lib.color")
local util = require("gondolin.lib.util")
local clamp = util.clamp
local scale_log = util.scale_log
local scale_log_asymmetric = util.scale_log_asymmetric

local M = {}

---@param opts? GondolinConfig
---@return GondolinColors
function M.setup(opts)
	opts = require("gondolin.config").extend(opts)

	-- Add to and/or override palette_colors
	local updated_palette_colors = vim.tbl_extend("force", M.palette, opts.colors.palette or {})

	-- Generate the theme according to the updated palette colors
	local current_theme = util.get_current_theme(opts)
	local theme_path = "gondolin.themes." .. current_theme
	local theme_colors = require(theme_path).get(opts, updated_palette_colors)

	-- Add to and/or override theme_colors
	local updated_theme_colors = vim.tbl_deep_extend("force", theme_colors, opts.colors.theme[current_theme] or {})

	-- return palette_colors and theme_colors
	return {
		theme = updated_theme_colors,
		palette = updated_palette_colors,
	}
end

---@param hex ColorSpec
---@param offset number
---@return ColorSpec
function M.apply_brightness(hex, offset)
	local clamped_offset = clamp(offset, -1, 1)
	local rescaled_offset = scale_log(clamped_offset, 3, 0.2)
	return color(hex):brighten(rescaled_offset):to_hex()
end

---@param hex ColorSpec
---@param offset number
---@return ColorSpec
function M.apply_saturation(hex, offset)
	local clamped_offset = clamp(offset, -1, 1)
	local rescaled_offset = scale_log_asymmetric(clamped_offset, 3, 0.2, 0.5)
	return color(hex):saturate(rescaled_offset):to_hex()
end

---@param colors GondolinColors
---@param opts GondolinConfig
---@return table<number, ColorSpec>
function M.terminal(colors, opts)
	local current_theme = util.get_current_theme(opts)
	for hl, _ in pairs(colors.theme.term) do
		if opts.color_balance[current_theme].saturation ~= 0 then
			colors.theme.term[hl] =
				M.apply_saturation(colors.theme.term[hl], opts.color_balance[current_theme].saturation)
		end
		if opts.color_balance[current_theme].brightness ~= 0 then
			colors.theme.term[hl] =
				M.apply_brightness(colors.theme.term[hl], opts.color_balance[current_theme].brightness)
		end
	end

	return {
		[0] = colors.theme.term.black,
		[1] = colors.theme.term.red,
		[2] = colors.theme.term.green,
		[3] = colors.theme.term.yellow,
		[4] = colors.theme.term.blue,
		[5] = colors.theme.term.magenta,
		[6] = colors.theme.term.cyan,
		[7] = colors.theme.term.white,
		[8] = colors.theme.term.black_bright,
		[9] = colors.theme.term.red_bright,
		[10] = colors.theme.term.green_bright,
		[11] = colors.theme.term.yellow_bright,
		[12] = colors.theme.term.blue_bright,
		[13] = colors.theme.term.magenta_bright,
		[14] = colors.theme.term.cyan_bright,
		[15] = colors.theme.term.white_bright,
		[16] = colors.theme.term.indexed1,
		[17] = colors.theme.term.indexed2,
	}
end

---@type PaletteColors
M.palette = {
	-- ==============================================
	-- GONDOLIN DARK PALETTE (based on Zed Dark theme)
	-- ==============================================

	-- Background Shades (darkest to lightest)
	bg0 = "#060809",      -- darkest (terminal dim black)
	bg1 = "#080A0D",      -- main editor background
	bg2 = "#0d0f13",      -- surface/panel background
	bg3 = "#0E1114",      -- elevated surface
	bg4 = "#1a1d23",      -- active line, subheader
	bg5 = "#1C2129",      -- element background, borders
	bg6 = "#212430",      -- diagnostic backgrounds
	bg7 = "#262C36",      -- hover states
	bg8 = "#404658",      -- bright black

	-- Foreground Shades (brightest to dimmest)
	fg0 = "#ffffff",      -- bright white
	fg1 = "#D0D3DA",      -- main foreground
	fg2 = "#C4CAD4",      -- text
	fg3 = "#c6cad7",      -- terminal foreground
	fg4 = "#A2AEC0",      -- active line number
	fg5 = "#a9aec1",      -- hidden/ignored
	fg6 = "#94a3b8",      -- dim white
	fg7 = "#6A7587",      -- dim foreground
	fg8 = "#3D4550",      -- line numbers, nontext
	fg9 = "#454E5C",      -- disabled text

	-- Syntax: Variables & Identifiers
	variable = "#7DA7F7",        -- variables
	variableSpecial = "#A6C6FE", -- special variables

	-- Syntax: Functions
	func = "#A6C6FE",            -- functions, methods

	-- Syntax: Strings
	string = "#AAE08A",          -- strings
	stringDoc = "#91D8CE",       -- doc strings
	stringRegex = "#FFB78C",     -- regex
	stringEscape = "#eebcbc",    -- escape sequences
	stringSymbol = "#e6c0b6",    -- symbols in strings
	stringUrl = "#FFE5DF",       -- URLs
	character = "#91D8CE",       -- characters

	-- Syntax: Constants & Numbers
	constant = "#FFBE78",        -- constants, numbers, booleans
	float = "#FFB78C",           -- floats

	-- Syntax: Types
	type = "#FFBE78",            -- types
	typeDefinition = "#F5D8A0",  -- type definitions
	typeInterface = "#F5D8A0",   -- interfaces

	-- Syntax: Keywords
	keyword = "#CC95FF",         -- main keywords
	keywordAlt = "#DAB0F6",      -- modifier, function, operator keywords
	keywordDirective = "#FFCAEE", -- preprocessor directives
	keywordExport = "#A9E1EB",   -- export keyword

	-- Syntax: Operators & Punctuation
	operator = "#A9E1EB",        -- operators
	punctuation = "#A4ACCB",     -- brackets, delimiters
	punctSpecial = "#FFCECE",    -- special punctuation

	-- Syntax: Comments
	comment = "#3D4550",         -- comments
	commentDoc = "#A4ACCB",      -- doc comments
	commentError = "#F79294",    -- error comments
	commentWarning = "#F5D8A0",  -- warning comments
	commentHint = "#9CBAFF",     -- hint comments
	commentTodo = "#FFCECE",     -- TODO comments
	commentNote = "#FFE5DF",     -- note comments

	-- Syntax: Tags (HTML/JSX)
	tag = "#FF889E",             -- tags
	tagAttribute = "#F5D8A0",    -- tag attributes
	tagDelimiter = "#91D8CE",    -- tag delimiters
	tagDoctype = "#DAB0F6",      -- doctype

	-- Syntax: Other
	attribute = "#eebcbc",       -- attributes
	property = "#9CBAFF",        -- properties
	constructor = "#FFCECE",     -- constructors
	parameter = "#FAA9AC",       -- parameters
	field = "#CACBFF",           -- fields
	namespace = "#F5D8A0",       -- namespaces
	module = "#F5D8A0",          -- modules
	label = "#95D1EC",           -- labels
	symbol = "#eebcbc",          -- symbols
	embedded = "#FAA9AC",        -- embedded code
	enum = "#91D8CE",            -- enums
	parent = "#FFB78C",          -- parent references
	predictive = "#838AA4",      -- predictive text

	-- Syntax: Text & Markup
	text = "#D6E0FF",            -- plain text
	textLiteral = "#AAE08A",     -- literal text
	emphasisStrong = "#FAA9AC",  -- bold
	emphasis = "#FAA9AC",        -- italic
	title = "#D6E0FF",           -- titles
	linkText = "#CACBFF",        -- link text
	linkUri = "#9CBAFF",         -- link URIs

	-- Syntax: Diff
	diffPlus = "#AAE08A",        -- added
	diffMinus = "#F79294",       -- removed

	-- Diagnostics
	error = "#FF7A77",           -- error
	warning = "#FFE878",         -- warning
	info = "#83AEF8",            -- info
	hint = "#958BCC",            -- hint
	success = "#B9EC86",         -- success/ok
	conflict = "#FFA877",        -- conflict

	-- Diagnostics Backgrounds
	errorBg = "#212430",
	warningBg = "#212430",
	infoBg = "#1a2535",
	hintBg = "#302f43",
	successBg = "#212430",

	-- VCS/Git Colors
	vcsAdded = "#B9EC86",
	vcsDeleted = "#FF889E",
	vcsModified = "#83AEF8",
	vcsRenamed = "#FFEF90",
	vcsIgnored = "#B9BED1",
	vcsConflict = "#FFA877",
	vcsConflictOurs = "#3d2020",
	vcsConflictTheirs = "#203d25",

	-- UI: Borders
	border = "#1C2129",
	borderVariant = "#353d4a",
	borderFocused = "#83AEF8",
	borderSelected = "#0a0b0f",

	-- UI: Search
	searchMatch = "#0f3570",

	-- UI: Selection
	selection = "#1a1d23",

	-- UI: Scrollbar
	scrollThumb = "#2a3040",
	scrollThumbHover = "#3a4555",
	scrollThumbActive = "#4a5565",

	-- UI: Accent
	accent = "#83AEF8",          -- primary accent color

	-- Terminal Colors (ANSI)
	termBlack = "#080A0D",
	termRed = "#FF7A77",
	termGreen = "#B9EC86",
	termYellow = "#FFE878",
	termBlue = "#83AEF8",
	termMagenta = "#FF8DFF",
	termCyan = "#83AEF8",
	termWhite = "#D6DAE7",

	-- Terminal Bright Colors
	termBlackBright = "#505668",
	termRedBright = "#FF7774",
	termGreenBright = "#B9FF6C",
	termYellowBright = "#FFE878",
	termBlueBright = "#71FEFF",
	termMagentaBright = "#FF8DFF",
	termCyanBright = "#71FFDF",
	termWhiteBright = "#ffffff",

	-- Terminal Dim Colors
	termRedDim = "#C85C59",
	termGreenDim = "#8EB06A",
	termYellowDim = "#D4B65F",
	termBlueDim = "#6587B8",
	termMagentaDim = "#D071D3",
	termCyanDim = "#6587B8",
	termWhiteDim = "#A4B3C8",
	termBlackDim = "#060809",

	-- Mode Colors
	modeNormal = "#83AEF8",      -- blue accent
	modeInsert = "#B9EC86",      -- green
	modeVisual = "#CC95FF",      -- purple keyword
	modeReplace = "#FF7A77",     -- red
	modeCommand = "#FFE878",     -- yellow

	-- Rainbow Colors (for delimiters, etc.)
	rainbow1 = "#FF7A77",        -- red
	rainbow2 = "#FFE878",        -- yellow
	rainbow3 = "#B9EC86",        -- green
	rainbow4 = "#83AEF8",        -- blue
	rainbow5 = "#CC95FF",        -- purple
	rainbow6 = "#FF8DFF",        -- magenta
	rainbow7 = "#91D8CE",        -- cyan
}

return M

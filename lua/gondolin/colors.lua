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

	-- Generate the theme according to the current variant
	local current_theme = util.get_current_theme(opts)

	-- Add to and/or override palette_colors
	local base_palette = current_theme == "light" and M.light_palette or M.palette
	local updated_palette_colors = vim.tbl_extend("force", vim.deepcopy(base_palette), opts.colors.palette or {})

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
	bg0 = "#060809", -- darkest (terminal dim black)
	bg1 = "#080A0D", -- main editor background
	bg2 = "#0d0f13", -- surface/panel background
	bg3 = "#0E1114", -- elevated surface
	bg4 = "#1a1d23", -- active line, subheader
	bg5 = "#1C2129", -- element background, borders
	bg6 = "#212430", -- diagnostic backgrounds
	bg7 = "#262C36", -- hover states
	bg8 = "#404658", -- bright black

	-- Foreground Shades (brightest to dimmest)
	fg0 = "#ffffff", -- bright white
	fg1 = "#D0D3DA", -- main foreground
	fg2 = "#C4CAD4", -- text
	fg3 = "#c6cad7", -- terminal foreground
	fg4 = "#A2AEC0", -- active line number
	fg5 = "#a9aec1", -- hidden/ignored
	fg6 = "#94a3b8", -- dim white
	fg7 = "#6A7587", -- dim foreground
	fg8 = "#3D4550", -- line numbers, nontext
	fg9 = "#454E5C", -- disabled text

	-- Syntax: Variables & Identifiers
	variable = "#7DA7F7", -- variables
	variableSpecial = "#A6C6FE", -- special variables

	-- Syntax: Functions
	func = "#A6C6FE", -- functions, methods

	-- Syntax: Strings
	string = "#AAE08A", -- strings
	stringDoc = "#91D8CE", -- doc strings
	stringRegex = "#FFB78C", -- regex
	stringEscape = "#eebcbc", -- escape sequences
	stringSymbol = "#e6c0b6", -- symbols in strings
	stringUrl = "#FFE5DF", -- URLs
	character = "#91D8CE", -- characters

	-- Syntax: Constants & Numbers
	constant = "#FFBE78", -- constants, numbers, booleans
	float = "#FFB78C", -- floats

	-- Syntax: Types
	type = "#FFBE78", -- types
	typeDefinition = "#F5D8A0", -- type definitions
	typeInterface = "#F5D8A0", -- interfaces

	-- Syntax: Keywords
	keyword = "#CC95FF", -- main keywords
	keywordAlt = "#DAB0F6", -- modifier, function, operator keywords
	keywordDirective = "#FFCAEE", -- preprocessor directives
	keywordExport = "#A9E1EB", -- export keyword

	-- Syntax: Operators & Punctuation
	operator = "#A9E1EB", -- operators
	punctuation = "#A4ACCB", -- brackets, delimiters
	punctSpecial = "#FFCECE", -- special punctuation

	-- Syntax: Comments
	comment = "#3D4550", -- comments
	commentDoc = "#A4ACCB", -- doc comments
	commentError = "#F79294", -- error comments
	commentWarning = "#F5D8A0", -- warning comments
	commentHint = "#9CBAFF", -- hint comments
	commentTodo = "#FFCECE", -- TODO comments
	commentNote = "#FFE5DF", -- note comments

	-- Syntax: Tags (HTML/JSX)
	tag = "#FF889E", -- tags
	tagAttribute = "#F5D8A0", -- tag attributes
	tagDelimiter = "#91D8CE", -- tag delimiters
	tagDoctype = "#DAB0F6", -- doctype

	-- Syntax: Other
	attribute = "#eebcbc", -- attributes
	property = "#9CBAFF", -- properties
	constructor = "#FFCECE", -- constructors
	parameter = "#FAA9AC", -- parameters
	field = "#CACBFF", -- fields
	namespace = "#F5D8A0", -- namespaces
	module = "#F5D8A0", -- modules
	label = "#95D1EC", -- labels
	symbol = "#eebcbc", -- symbols
	embedded = "#FAA9AC", -- embedded code
	enum = "#91D8CE", -- enums
	parent = "#FFB78C", -- parent references
	predictive = "#838AA4", -- predictive text

	-- Syntax: Text & Markup
	text = "#D6E0FF", -- plain text
	textLiteral = "#AAE08A", -- literal text
	emphasisStrong = "#FAA9AC", -- bold
	emphasis = "#FAA9AC", -- italic
	title = "#D6E0FF", -- titles
	linkText = "#CACBFF", -- link text
	linkUri = "#9CBAFF", -- link URIs

	-- Syntax: Diff
	diffPlus = "#AAE08A", -- added
	diffMinus = "#F79294", -- removed

	-- Diagnostics
	error = "#FF7A77", -- error
	warning = "#FFE878", -- warning
	info = "#83AEF8", -- info
	hint = "#958BCC", -- hint
	success = "#B9EC86", -- success/ok
	conflict = "#FFA877", -- conflict

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
	accent = "#83AEF8", -- primary accent color

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
	modeNormal = "#83AEF8", -- blue accent
	modeInsert = "#B9EC86", -- green
	modeVisual = "#CC95FF", -- purple keyword
	modeReplace = "#FF7A77", -- red
	modeCommand = "#FFE878", -- yellow

	-- Rainbow Colors (for delimiters, etc.)
	rainbow1 = "#FF7A77", -- red
	rainbow2 = "#FFE878", -- yellow
	rainbow3 = "#B9EC86", -- green
	rainbow4 = "#83AEF8", -- blue
	rainbow5 = "#CC95FF", -- purple
	rainbow6 = "#FF8DFF", -- magenta
	rainbow7 = "#91D8CE", -- cyan
}

---@type PaletteColors
M.light_palette = {
	-- ==============================================
	-- GONDOLIN LIGHT PALETTE (inspired by Hunk Paper)
	-- ==============================================

	-- Warm paper surfaces
	bg0 = "#e8dccd",
	bg1 = "#f4efe6",
	bg2 = "#fffaf3",
	bg3 = "#f8f1e7",
	bg4 = "#eee4d6",
	bg5 = "#e4d6c6",
	bg6 = "#d8c8b3",
	bg7 = "#ccb99f",
	bg8 = "#bca78c",

	-- Ink tones
	fg0 = "#1f160d",
	fg1 = "#2f2417",
	fg2 = "#3b2d1f",
	fg3 = "#3f3326",
	fg4 = "#5a4b3a",
	fg5 = "#6b5b49",
	fg6 = "#786753",
	fg7 = "#8f7a65",
	fg8 = "#9b8367",
	fg9 = "#b39c80",

	-- Syntax: Variables & Identifiers
	variable = "#2f2417",
	variableSpecial = "#77593a",

	-- Syntax: Functions
	func = "#5a4a8e",

	-- Syntax: Strings
	string = "#4a6890",
	stringDoc = "#356b7f",
	stringRegex = "#7d5bc4",
	stringEscape = "#9f6c1f",
	stringSymbol = "#7b5a35",
	stringUrl = "#4a6890",
	character = "#356b7f",

	-- Syntax: Constants & Numbers
	constant = "#9f6c1f",
	float = "#9f6c1f",

	-- Syntax: Types
	type = "#5f5f9a",
	typeDefinition = "#5f5f9a",
	typeInterface = "#5f5f9a",

	-- Syntax: Keywords
	keyword = "#7b5a35",
	keywordAlt = "#77593a",
	keywordDirective = "#7d5bc4",
	keywordExport = "#356b7f",

	-- Syntax: Operators & Punctuation
	operator = "#77593a",
	punctuation = "#8f7a65",
	punctSpecial = "#9f6c1f",

	-- Syntax: Comments
	comment = "#8f7a65",
	commentDoc = "#786753",
	commentError = "#b4545b",
	commentWarning = "#9f6c1f",
	commentHint = "#4a6890",
	commentTodo = "#7d5bc4",
	commentNote = "#356b7f",

	-- Syntax: Tags (HTML/JSX)
	tag = "#7b5a35",
	tagAttribute = "#9f6c1f",
	tagDelimiter = "#8f7a65",
	tagDoctype = "#7d5bc4",

	-- Syntax: Other
	attribute = "#9f6c1f",
	property = "#356b7f",
	constructor = "#5a4a8e",
	parameter = "#77593a",
	field = "#356b7f",
	namespace = "#5f5f9a",
	module = "#5f5f9a",
	label = "#4a6890",
	symbol = "#7b5a35",
	embedded = "#77593a",
	enum = "#5f5f9a",
	parent = "#9f6c1f",
	predictive = "#9b8367",

	-- Syntax: Text & Markup
	text = "#2f2417",
	textLiteral = "#4a6890",
	emphasisStrong = "#77593a",
	emphasis = "#77593a",
	title = "#2f2417",
	linkText = "#5a4a8e",
	linkUri = "#4a6890",

	-- Syntax: Diff
	diffPlus = "#3f8d58",
	diffMinus = "#b4545b",

	-- Diagnostics
	error = "#b4545b",
	warning = "#9f6c1f",
	info = "#4a6890",
	hint = "#7d5bc4",
	success = "#3f8d58",
	conflict = "#9f6c1f",

	-- Diagnostics Backgrounds
	errorBg = "#fbebeb",
	warningBg = "#f4eadb",
	infoBg = "#dcebf4",
	hintBg = "#efe6ff",
	successBg = "#eaf8ec",

	-- VCS/Git Colors
	vcsAdded = "#3f8d58",
	vcsDeleted = "#b4545b",
	vcsModified = "#7d5bc4",
	vcsRenamed = "#9f6c1f",
	vcsIgnored = "#9b8367",
	vcsConflict = "#9f6c1f",
	vcsConflictOurs = "#dff0e1",
	vcsConflictTheirs = "#f6ddde",

	-- UI: Borders
	border = "#d8c8b3",
	borderVariant = "#ccb99f",
	borderFocused = "#77593a",
	borderSelected = "#2f2417",

	-- UI: Search
	searchMatch = "#e3d7ff",

	-- UI: Selection
	selection = "#d7ccbe",

	-- UI: Scrollbar
	scrollThumb = "#d8c8b3",
	scrollThumbHover = "#ccb99f",
	scrollThumbActive = "#bca78c",

	-- UI: Accent
	accent = "#77593a",

	-- Terminal Colors (ANSI)
	termBlack = "#2f2417",
	termRed = "#b4545b",
	termGreen = "#3f8d58",
	termYellow = "#9f6c1f",
	termBlue = "#4a6890",
	termMagenta = "#7d5bc4",
	termCyan = "#356b7f",
	termWhite = "#f4efe6",

	-- Terminal Bright Colors
	termBlackBright = "#786753",
	termRedBright = "#c96369",
	termGreenBright = "#4d9d67",
	termYellowBright = "#b77d2c",
	termBlueBright = "#5778a5",
	termMagentaBright = "#8f6dd6",
	termCyanBright = "#427f95",
	termWhiteBright = "#fffaf3",

	-- Terminal Dim Colors
	termRedDim = "#8f464b",
	termGreenDim = "#347247",
	termYellowDim = "#7b5418",
	termBlueDim = "#3b5575",
	termMagentaDim = "#6548a0",
	termCyanDim = "#2d5a6b",
	termWhiteDim = "#d8c8b3",
	termBlackDim = "#1f160d",

	-- Mode Colors
	modeNormal = "#77593a",
	modeInsert = "#3f8d58",
	modeVisual = "#7d5bc4",
	modeReplace = "#b4545b",
	modeCommand = "#9f6c1f",

	-- Rainbow Colors (for delimiters, etc.)
	rainbow1 = "#b4545b",
	rainbow2 = "#9f6c1f",
	rainbow3 = "#3f8d58",
	rainbow4 = "#4a6890",
	rainbow5 = "#7d5bc4",
	rainbow6 = "#5a4a8e",
	rainbow7 = "#356b7f",
}


return M

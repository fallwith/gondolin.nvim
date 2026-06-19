local Config = require("gondolin.config")
local Colors = require("gondolin.colors")

local function channel(hex, start)
	return tonumber(hex:sub(start, start + 1), 16) / 255
end

local function linear(value)
	if value <= 0.03928 then
		return value / 12.92
	end

	return ((value + 0.055) / 1.055) ^ 2.4
end

local function luminance(hex)
	local red = linear(channel(hex, 2))
	local green = linear(channel(hex, 4))
	local blue = linear(channel(hex, 6))

	return 0.2126 * red + 0.7152 * green + 0.0722 * blue
end

local function contrast(first, second)
	local first_luminance = luminance(first)
	local second_luminance = luminance(second)
	local lighter = math.max(first_luminance, second_luminance)
	local darker = math.min(first_luminance, second_luminance)

	return (lighter + 0.05) / (darker + 0.05)
end

describe("light palette", function()
	before_each(function()
		Config.setup()
	end)

	it("keeps primary syntax readable on paper", function()
		local colors = Colors.setup({ _theme = "light" })
		local theme = colors.theme
		local paper = theme.ui.bg
		local primary_roles = {
			theme.ui.fg,
			theme.syn.identifier,
			theme.syn.fun,
			theme.syn.string,
			theme.syn.constant,
			theme.syn.keyword,
			theme.syn.member,
			theme.syn.operator,
			theme.syn.statement,
			theme.syn.type,
			theme.syn.preproc,
		}

		for _, role in ipairs(primary_roles) do
			assert.is_true(contrast(role, paper) >= 4, role)
		end
	end)

	it("keeps related semantic roles on the same hue family", function()
		local colors = Colors.setup({ _theme = "light" })
		local theme = colors.theme

		assert.same(theme.syn.constant, theme.syn.number)
		assert.same(theme.syn.constant, theme.syn.operator)
		assert.same(theme.syn.constant, theme.syn.symbol)
		assert.same(theme.syn.constant, theme.term.yellow)
		assert.same(theme.syn.type, theme.term.blue)
		assert.same(theme.syn.fun, theme.term.cyan)
		assert.same(theme.syn.string, theme.term.green)
		assert.same(theme.syn.keyword, theme.term.red)
		assert.same(theme.modes.normal, theme.syn.type)
		assert.same(theme.modes.command, theme.syn.constant)
	end)
end)

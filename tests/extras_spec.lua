describe("extra is loadable", function()
	local Config = require("gondolin.config")
	local extras = require("gondolin.extras")
	local context = require("gondolin.extras.context")

	before_each(function()
		Config.setup()
	end)

	local function theme_context(name, theme)
		local info = extras.mapping[name]
		local colors = require("gondolin.colors").setup({ _theme = theme })
		local filename = context.filename(name, info, theme)
		return context.with_metadata(
			colors.theme,
			info,
			filename,
			"gondolin-" .. theme,
			"Gondolin " .. (theme == "dark" and "Dark" or "Light"),
			theme
		)
	end

	local function palette_context(name)
		local info = extras.mapping[name]
		local colors = require("gondolin.colors").setup({ _theme = "dark" })
		local filename = context.filename(name, info, "palette")
		return context.with_metadata(colors.palette, info, filename, "gondolin-palette", "Gondolin Palette")
	end

	for name in vim.fs.dir("lua/gondolin/extras") do
		name = name:match("(.+)%.lua$")
		if name ~= "init" and name ~= "context" then
			it(name .. " has a generate function", function()
				local extra = require("gondolin.extras." .. name)
				assert.is_function(extra.generate)
			end)

			it(name .. " has a generate palette function if applicable", function()
				local extra = require("gondolin.extras." .. name)
				if extras.mapping[name].palette then
					assert.is_function(extra.generate_palette)
				end
			end)

			it(name .. " has a mapping", function()
				assert.is_true(extras.mapping[name] ~= nil)
			end)

			it(name .. " has an extension", function()
				assert.is_true(extras.mapping[name].ext ~= nil)
			end)

			it(name .. " has a url", function()
				assert.is_true(extras.mapping[name].url ~= nil)
			end)

			for _, theme in ipairs({ "dark", "light" }) do
				it(name .. " renders " .. theme .. " without unresolved templates", function()
					local extra = require("gondolin.extras." .. name)
					local out = extra.generate(theme_context(name, theme), {}, {})
					assert.is_string(context.assert_rendered(name, out))
				end)
			end

			it(name .. " renders palette without unresolved templates if applicable", function()
				local extra = require("gondolin.extras." .. name)
				if extras.mapping[name].palette then
					local out = extra.generate_palette(palette_context(name), {}, {})
					assert.is_string(context.assert_rendered(name, out))
				end
			end)
		end
	end
end)

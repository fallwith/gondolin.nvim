local Config = require("gondolin.config")
local util = require("gondolin.lib.util")

describe("wezterm themes are updated", function()
	before_each(function()
		Config.setup({
			integrations = {
				wezterm = {
					enabled = true,
				},
			},
		})
	end)

	it("theme updates on init", function()
		vim.cmd.colorscheme("gondolin")
		local theme = util.read(Config.options.integrations.wezterm.path)
		assert.same("gondolin-dark", theme)
	end)

	it("dark theme updates on init", function()
		vim.cmd.colorscheme("gondolin-dark")
		local theme = util.read(Config.options.integrations.wezterm.path)
		assert.same("gondolin-dark", theme)
	end)

	it("light theme updates on init", function()
		vim.cmd.colorscheme("gondolin-light")
		local theme = util.read(Config.options.integrations.wezterm.path)
		assert.same("gondolin-light", theme)
	end)
end)

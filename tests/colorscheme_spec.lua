local Config = require("gondolin.config")

describe("plugin loads", function()
	it("did proper init", function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("default")
		Config.setup()
		assert.same("default", vim.g.colors_name)
		assert.same("dark", vim.o.background)
	end)
end)

describe("gondolin colorscheme", function()
	before_each(function()
		Config.setup()
	end)

	it("loads with default background", function()
		vim.o.background = nil
		vim.cmd.colorscheme("gondolin")
		assert.same("gondolin", vim.g.colors_name)
	end)

	it("loads with dark background", function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("gondolin")
		assert.same("dark", vim.o.background)
		assert.same("gondolin", vim.g.colors_name)
	end)

	it("forces dark background when light is set", function()
		vim.o.background = "light"
		vim.cmd.colorscheme("gondolin")
		-- Gondolin is dark-only, so it should force dark
		assert.same("dark", vim.o.background)
		assert.same("gondolin", vim.g.colors_name)
	end)
end)

describe("gondolin-dark colorscheme", function()
	before_each(function()
		Config.setup()
	end)

	it("loads with dark background", function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("gondolin-dark")
		assert.same("dark", vim.o.background)
		assert.same("gondolin-dark", vim.g.colors_name)
	end)

	it("forces dark background when light is set", function()
		vim.o.background = "light"
		vim.cmd.colorscheme("gondolin-dark")
		-- Gondolin-dark forces dark mode
		assert.same("dark", vim.o.background)
		assert.same("gondolin-dark", vim.g.colors_name)
	end)
end)

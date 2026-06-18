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

	it("uses light background when light is set", function()
		vim.o.background = "light"
		vim.cmd.colorscheme("gondolin")
		assert.same("light", vim.o.background)
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
		assert.same("dark", vim.o.background)
		assert.same("gondolin-dark", vim.g.colors_name)
	end)
end)

describe("gondolin-light colorscheme", function()
	before_each(function()
		Config.setup()
	end)

	it("loads with light background", function()
		vim.o.background = "light"
		vim.cmd.colorscheme("gondolin-light")
		assert.same("light", vim.o.background)
		assert.same("gondolin-light", vim.g.colors_name)
	end)

	it("forces light background when dark is set", function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("gondolin-light")
		assert.same("light", vim.o.background)
		assert.same("gondolin-light", vim.g.colors_name)
	end)
end)

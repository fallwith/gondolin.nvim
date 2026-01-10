local Config = require("gondolin.config")
local Cache = require("gondolin.lib.cache")

describe("no cache on disabled", function()
	before_each(function()
		vim.cmd.colorscheme("default")
		Config.setup({ cache = false })
	end)

	it("on initial load", function()
		vim.cmd.colorscheme("gondolin-dark")
		assert.same(0, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))
	end)

	it("on theme reload", function()
		vim.cmd.colorscheme("gondolin-dark")
		assert.same(0, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))

		vim.cmd.colorscheme("gondolin-dark")
		assert.same(0, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))
	end)
end)

describe("cache builds", function()
	before_each(function()
		vim.cmd.colorscheme("default")
		Config.setup({ cache = true })
	end)

	after_each(function()
		Cache.delete("dark")
	end)

	it("on initial load", function()
		vim.cmd.colorscheme("gondolin-dark")
		assert.same(1, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))
	end)

	it("on theme reload", function()
		vim.cmd.colorscheme("gondolin-dark")
		assert.same(1, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))

		vim.cmd.colorscheme("gondolin-dark")
		assert.same(1, vim.fn.filereadable(vim.fn.stdpath("cache") .. "/gondolin-dark.json"))
	end)
end)

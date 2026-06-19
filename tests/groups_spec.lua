local Config = require("gondolin.config")
local Groups = require("gondolin.groups")

before_each(function()
	Config.setup()
end)

describe("group is loadable", function()
	for name in vim.fs.dir("lua/gondolin/groups/plugins") do
		name = name:match("(.+)%.lua$")
		it(name .. " has a plugin mapping", function()
			local mapping = false
			for _, v in pairs(Groups.plugins) do
				if v == name then
					mapping = true
					break
				end
			end
			assert.is_true(mapping, name)
		end)
	end
end)

describe("group color interface", function()
	it("uses one highlight module entrypoint", function()
		local paths = vim.api.nvim_get_runtime_file("lua/gondolin/groups/**/*.lua", true)

		for _, path in ipairs(paths) do
			if not path:match("/groups/init%.lua$") and not path:match("/groups/completion%.lua$") then
				local source = table.concat(vim.fn.readfile(path), "\n")
				assert.is_not_nil(source:match("function M%.get"), path)
				assert.is_nil(source:match("function M%.setup"), path)
			end
		end
	end)

	it("does not bypass theme colors", function()
		local paths = vim.api.nvim_get_runtime_file("lua/gondolin/groups/**/*.lua", true)

		for _, path in ipairs(paths) do
			local source = table.concat(vim.fn.readfile(path), "\n")
			assert.is_nil(source:match("colors%.palette"), path)
		end
	end)

	it("maps core treesitter captures explicitly", function()
		local opts = Config.extend({ all_plugins = false, auto_plugins = false })
		local colors = require("gondolin.colors").setup(opts)
		local groups = Groups.setup(colors, opts)

		assert.same(colors.theme.syn.type, groups["@module"].fg)
		assert.same(colors.theme.syn.fun, groups["@function.call"].fg)
		assert.same(colors.theme.syn.keyword, groups["@keyword.function"].fg)
		assert.same(colors.theme.syn.constant, groups["@constant"].fg)
		assert.same(colors.theme.syn.member, groups["@property"].fg)
	end)
end)

describe("group config", function()
	it("does all plugins", function()
		local opts = Config.extend({ all_plugins = true, auto_plugins = false })
		local all = {}
		for _, name in pairs(Groups.plugins) do
			all[name] = true
		end
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same(all, plugins)
	end)

	it("does no plugins", function()
		local opts = Config.extend({ all_plugins = false, auto_plugins = false })
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same({}, plugins)
	end)

	it("does manual plugins", function()
		local opts = Config.extend({
			all_plugins = false,
			auto_plugins = false,
			plugins = {
				aerial = true,
				snacks = true,
			},
		})
		local all = {}
		all.aerial = true
		all.snacks = true
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same(all, plugins)
	end)

	it("does auto plugins", function()
		local opts = Config.extend({
			all_plugins = false,
			auto_plugins = true,
		})
		local all = {}
		all.lazy = true
		all.mini = true
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same(all, plugins)
	end)

	it("handle multi-word plugins", function()
		local opts = Config.extend({
			all_plugins = false,
			auto_plugins = false,
			plugins = {
				neo_tree = true,
				snacks = true,
			},
		})
		local all = {}
		all.neo_tree = true
		all.snacks = true
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same(all, plugins)
	end)

	it("handle disabled plugins", function()
		local opts = Config.extend({
			all_plugins = false,
			auto_plugins = false,
			plugins = {
				aerial = false,
				snacks = true,
			},
		})
		local all = {}
		all.aerial = false
		all.snacks = true
		local colors = require("gondolin.colors").setup(opts)
		local _, plugins = Groups.setup(colors, opts)
		assert.same(all, plugins)
	end)
end)

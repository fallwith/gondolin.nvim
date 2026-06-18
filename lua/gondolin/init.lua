local util = require("gondolin.lib.util")
local cache = require("gondolin.lib.cache")
local config = require("gondolin.config")

local M = {}

---@param opts? GondolinConfig
---@return GondolinColors, GondolinGroups, GondolinConfig
function M.load(opts)
	opts = require("gondolin.config").extend(opts)

	local current_theme = util.get_current_theme(opts)
	vim.o.background = current_theme

	if opts.integrations.wezterm.enabled then
		util.write(vim.fn.expand(opts.integrations.wezterm.path), "gondolin-" .. current_theme)
	else
		if vim.fn.filereadable(vim.fn.expand(opts.integrations.wezterm.path)) == 1 then
			os.remove(vim.fn.expand(opts.integrations.wezterm.path))
		end
	end

	if opts.cache then
		vim.api.nvim_create_user_command("GondolinCache", function()
			for name, _ in pairs(package.loaded) do
				if name:match("^gondolin.") then
					package.loaded[name] = nil
				end
			end

			local theme = util.get_current_theme(opts)
			local colors = require("gondolin.colors").setup(opts)
			local groups, _ = require("gondolin.groups").setup(colors, opts)
			local term_colors = require("gondolin.colors").terminal(colors, opts)
			local cache_opts = cache.get_opts(opts)

			local container = cache.create_container(colors, groups, term_colors, cache_opts)
			cache.write(theme, container)
			vim.cmd.colorscheme("gondolin")
		end, { desc = "Rebuild the cache for the current Gondolin theme" })
	else
		for _, theme in ipairs({ "dark", "light" }) do
			if vim.fn.filereadable(cache.file(theme)) == 1 then
				cache.delete(theme)
			end
		end
	end

	return require("gondolin.themes").setup(opts)
end

M.setup = config.setup

return M

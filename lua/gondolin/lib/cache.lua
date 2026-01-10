local cache_version = 1.0 -- Bump when the cache format changes to automatically invalidate the cache.
local util = require("gondolin.lib.util")

local M = {}

--- Get the cache file path for a given key
---@param key string
---@return string
function M.file(key)
	return vim.fn.stdpath("cache") .. "/gondolin-" .. key .. ".json"
end

--- Read data from the cache file for a given key
---@param key string
---@return table|nil
function M.read(key)
	if vim.fn.filereadable(M.file(key)) == 0 then
		return nil
	end

	local ok, ret = pcall(function()
		return vim.json.decode(util.read(M.file(key)), { luanil = {
			object = true,
			array = true,
		} })
	end)
	if not ok then
		vim.notify("Error loading cached colorscheme: " .. ret, vim.log.levels.ERROR, { title = "gondolin.nvim" })
	end
	return ok and ret or nil
end

--- Write data to the cache file for a given key
---@param key string
---@param data table
function M.write(key, data)
	local ok = pcall(util.write, M.file(key), vim.json.encode(data))
	if ok then
		vim.notify(
			"Cache updated: gondolin-" .. key .. ".json",
			vim.log.levels.INFO,
			{ title = "gondolin.nvim" }
		)
	end
end

--- Delete the cache file for a given key
---@param key string
function M.delete(key)
	pcall(vim.uv.fs_unlink, M.file(key))
end

-- Apply main highlights.
---@param data GondolinCache
function M.apply(data)
	for group, spec in pairs(data.highlights) do
		vim.api.nvim_set_hl(0, group, spec)
	end
end

-- Apply terminal colors.
---@param data GondolinCache
function M.apply_terminal(data)
	for idx, color in pairs(data.termcolors) do
		vim.g["terminal_color_" .. idx] = color
	end
end

--- Get the options that will be used to validate the cache.
---@param opts GondolinConfig
---@return GondolinConfig
function M.get_opts(opts)
	return {
		transparent = opts.transparent,
		gutter = opts.gutter,
		diag_background = opts.diag_background,
		dim_inactive = opts.dim_inactive,
		styles = opts.styles,
		colors = opts.colors,
		color_balance = opts.color_balance,
		plugins = opts.plugins,
	}
end

-- Cache structure.
---@param colors GondolinColors
---@param highlights table<string, vim.api.keyset.highlight>
---@param termcolors table<number, ColorSpec>
---@param opts GondolinConfig
---@return GondolinCache
function M.create_container(colors, highlights, termcolors, opts)
	return {
		colors = colors,
		highlights = highlights,
		termcolors = termcolors,
		opts = opts,
		version = cache_version,
	}
end

--- Check if the cache contents match the current configuration.
---@param cache GondolinCache
---@param opts GondolinConfig | nil
---@return boolean
function M.inputs_match(cache, opts)
	if not cache or not opts then
		return false
	end
	if cache_version > cache.version then
		return false
	end
	return vim.deep_equal(cache.opts, opts)
end

return M

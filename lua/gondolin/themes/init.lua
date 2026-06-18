local cache = require("gondolin.lib.cache")

local M = {}

---@param opts? GondolinConfig
function M.setup(opts)
	opts = require("gondolin.config").extend(opts)

	-- only needed to clear when not the default colorscheme
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	vim.o.termguicolors = true
	local current_theme = require("gondolin.lib.util").get_current_theme(opts)
	vim.g.colors_name = opts._theme == "auto" and "gondolin" or "gondolin-" .. current_theme

	local cached = nil
	local cache_opts = cache.get_opts(opts)

	if opts.cache then
		cached = cache.read(current_theme)
	end

	if opts.cache and cached and cache.inputs_match(cached, cache_opts) then
		cache.apply(cached)
		if opts.terminal_colors then
			cache.apply_terminal(cached)
		end
		return cached.colors, cached.highlights, opts
	else
		local apply_saturation = require("gondolin.colors").apply_saturation
		local apply_brightness = require("gondolin.colors").apply_brightness
		local colors = require("gondolin.colors").setup(opts)
		local groups, _ = require("gondolin.groups").setup(colors, opts)
		local term_colors = require("gondolin.colors").terminal(colors, opts)

		for hl, spec in pairs(groups) do
			spec = type(spec) == "string" and { link = spec } or spec
			for _, field in ipairs({ "bg", "fg", "sp" }) do
				if spec[field] then
					if opts.color_balance[current_theme].saturation ~= 0 then
						spec[field] = apply_saturation(spec[field], opts.color_balance[current_theme].saturation)
					end
					if opts.color_balance[current_theme].brightness ~= 0 then
						spec[field] = apply_brightness(spec[field], opts.color_balance[current_theme].brightness)
					end
				end
			end
			vim.api.nvim_set_hl(0, hl, spec)
		end

		if opts.cache then
			local container = cache.create_container(colors, groups, term_colors, cache_opts)
			cache.write(current_theme, container)
		end

		return colors, groups, opts
	end
end

return M

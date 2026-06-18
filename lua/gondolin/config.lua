local M = {}

---@class GondolinConfig
M.defaults = {
	-- (internal) theme variant: "dark", "light", or "auto"
	_theme = "dark",

	-- enable undercurls for underlined text
	undercurl = true,
	-- transparent background
	transparent = false,
	-- highlight background for the left gutter
	gutter = false,
	-- background for diagnostic virtual text
	diag_background = true,
	-- dim inactive windows. disabled when transparent
	dim_inactive = false,
	-- cursor color. set to a hex color string to customize, or leave nil for default (fg)
	cursor_color = nil,
	-- set colors for terminal buffers
	terminal_colors = true,
	-- cache highlights and colors for faster startup.
	-- turning this on will require rebuilding the cache whenever you change your config.
	cache = false,

	styles = {
		-- style for comments
		comment = { italic = true },
		-- style for functions
		functions = { italic = false },
		-- style for keywords
		keyword = { italic = false, bold = false },
		-- style for statements
		statement = { italic = false, bold = false },
		-- style for types
		type = { italic = false },
	},
	-- override default palette and theme colors
	colors = {
		palette = {},
		theme = {
			dark = {},
			light = {},
		},
	},
	-- adjust overall color balance for the theme [-1, 1]
	color_balance = {
		dark = { brightness = 0, saturation = 0 },
		light = { brightness = 0, saturation = 0 },
	},
	-- override highlight groups
	overrides = function(colors)
		return {}
	end,

	-- uses lazy.nvim, if installed, to automatically enable needed plugins
	auto_plugins = true,
	-- enable highlights for all plugins (disabled if using lazy.nvim)
	all_plugins = package.loaded.lazy == nil,
	-- manually enable/disable individual plugins.
	-- check the `groups/plugins` directory for the exact names
	plugins = {
		-- examples:
		-- rainbow_delimiters = true
		-- which_key = false
	},

	-- enable integrations with other applications
	integrations = {
		-- automatically set wezterm theme to match the current neovim theme
		wezterm = {
			enabled = false,
			-- neovim will write the theme name to this file
			-- wezterm will read from this file to know which theme to use
			path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme",
		},
	},
}

---@type GondolinConfig
M.options = nil

---@param options? GondolinConfig
function M.setup(options)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})

	if M.options.integrations.wezterm.enabled then
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				os.remove(vim.fn.expand(M.options.integrations.wezterm.path))
			end,
		})
	end
end

---@param opts? GondolinConfig
function M.extend(opts)
	return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
	__index = function(_, k)
		if k == "options" then
			return M.defaults
		end
	end,
})

return M

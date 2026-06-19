local Util = require("gondolin.lib.util")
local Context = require("gondolin.extras.context")

local M = {}

-- map of plugin name to plugin extension
--- @type table<string, {ext:string, url:string, label?:string, subdir?: string, sep?:string, palette?:boolean}>
-- stylua: ignore
M.mapping = {
  alacritty        = { ext = "toml", url = "https://github.com/alacritty/alacritty", label = "Alacritty" },
  foot             = { ext = "ini", url= "https://codeberg.org/dnkl/foot", label = "Foot" },
  fzf              = { ext = "rc", url = "https://github.com/junegunn/fzf/tree/master#environment-variables", label = "Fzf" },
  ghostty          = { ext = "", url = "https://github.com/ghostty-org/ghostty", label = "Ghostty" },
  kitty            = { ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty" },
  lazygit          = { ext = "yml", url = "https://github.com/jesseduffield/lazygit", label = "lazygit" },
  nushell          = { ext = "nu", url = "https://www.nushell.sh/", label = "Nushell" },
  opencode         = { ext = "json", url = "https://opencode.ai/docs/customization/themes", label = "OpenCode" },
  tailwind         = { ext = "css", url = "https://tailwindcss.com/", label = "tailwind", palette = true },
  terminator       = { ext = "conf", url = "https://gnome-terminator.readthedocs.io/en/latest/config.html", label = "Terminator" },
  termux           = { ext = "properties", url = "https://termux.dev/", label = "Termux" },
  tilix            = { ext = "jsonc", url = "https://github.com/gnunn1/tilix", label = "Tilix" },
  tmux             = { ext = "conf", url = "https://github.com/tmux/tmux", label = "tmux" },
  wezterm          = { ext = "toml", url = "https://wezterm.org/config/appearance.html", label = "Wezterm" },
  wezterm_tabline  = { ext = "lua", url = "https://github.com/michaelbrusegard/tabline.wez", label = "Wezterm Tabline" },
  windows_terminal = { ext = "jsonc", url = "https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes", label = "Windows Terminal" },
  vscode_terminal  = { ext = "jsonc", url = "https://code.visualstudio.com/api/references/theme-color", label = "VSCode Terminal" },
  vivid            = { ext = "yml", url= "https://github.com/sharkdp/vivid", label = "Vivid" },
  zellij           = { ext = "kdl", url= "https://zellij.dev/", label = "Zellij" },
}

local function load_colors(opts)
	local gondolin = require("gondolin")
	opts = vim.tbl_deep_extend("force", { all_plugins = true }, opts or {})
	local ok, colors, groups, kopts = pcall(function()
		return gondolin.load(opts)
	end)
	if not ok then
		error("failed to load Gondolin colors: " .. colors)
	end
	return colors, groups, kopts
end

function M.setup()
	vim.o.background = "dark"

	local themes = {
		dark = "Dark",
		light = "Light",
	}

	---@type string[]
	local names = vim.tbl_keys(M.mapping)
	table.sort(names)

	for _, extra in ipairs(names) do
		local info = M.mapping[extra]
		local plugin = require("gondolin.extras." .. extra)

		-- colors for each theme
		for theme, theme_name in pairs(themes) do
			local colors, groups, kopts = load_colors({ _theme = theme })

			if colors and colors.theme then
				local filename = Context.filename(extra, info, theme)
				local path = vim.fn.expand("%:p:h") .. "/extras/" .. filename

				local t = Context.with_metadata(
					colors.theme,
					info,
					filename,
					"gondolin-" .. theme,
					"Gondolin " .. theme_name,
					theme
				)
				print("[write] " .. filename)

				local out = Context.assert_rendered(extra, plugin.generate(t, groups, kopts))
				Util.write(path, out)
			end
		end

		-- palette colors, if applicable
		if info.palette == true then
			local colors, groups, kopts = load_colors({ _theme = "dark" })

			if colors and colors.palette then
				local filename = Context.filename(extra, info, "palette")
				local path = vim.fn.expand("%:p:h") .. "/extras/" .. filename

				local p = Context.with_metadata(colors.palette, info, filename, "gondolin-palette", "Gondolin Palette")
				print("[write] " .. filename)

				local outp = Context.assert_rendered(extra, plugin.generate_palette(p, groups, kopts))
				Util.write(path, outp)
			end
		end
	end
end

return M

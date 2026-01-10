local util = require("gondolin.lib.util")

local M = {}

--- @param colors ThemeColors
function M.generate(colors)
	local tmux = util.template(
		[[
# ${_style_name} - tmux theme
# ${_upstream_url}

color_bg0="${ui.bg_m3}"
color_bg1="${ui.bg_m2}"
color_bg2="${ui.bg_m1}"
color_bg3="${ui.bg_p2}"
color_fg0="${ui.fg}"
color_fg1="${ui.fg_dim}"
color_red="${diag.error}"
color_orange="${syn.number}"
color_yellow="${diag.warning}"
color_green="${diag.ok}"
color_blue="${modes.normal}"
color_purple="${syn.keyword}"
color_grey0="${ui.nontext}"
color_grey1="${ui.fg_dimmer}"

# by default window names will just be their index
set-option -g automatic-rename              on
set-option -g automatic-rename-format       "#I"

# set to 12 for a 12-hour clock
set-option -g clock-mode-style              24
set-option -g clock-mode-colour             "$color_green"

# NOTE: color variable expansion only works in double quotes
set-option -g status-fg                     "$color_fg0"
set-option -g status-bg                     "$color_bg1"
set-option -g copy-mode-current-match-style "fg=$color_bg0,bg=$color_yellow"
set-option -g copy-mode-match-style         "fg=$color_bg0,bg=$color_blue"
set-option -g menu-selected-style           "fg=$color_bg0,bg=$color_blue"
set-option -g menu-style                    "fg=$color_fg0,bg=$color_bg1"
set-option -g message-style                 "bg=$color_yellow,fg=$color_bg0"
set-option -g message-command-style         "bg=$color_bg2,fg=$color_fg0"
set-option -g mode-style                    "bg=$color_bg2,fg=$color_fg0"
set-option -g pane-active-border-style      "fg=$color_blue"
set-option -g pane-border-lines             "heavy"
set-option -g pane-border-style             "fg=$color_bg3"
set-option -g popup-border-lines            "rounded"
set-option -g status-right-style            "fg=$color_fg1"
set-option -g window-status-current-style   "fg=$color_blue"
set-option -g window-status-style           "fg=$color_fg1"
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

# display the window index number or index-number:name if has a name
set-option -g window-status-separator      ''
set-option -g window-status-format         '#[fg=${ui.fg_dim}]#[bg=${ui.bg_m2}] #{?#{==:#W, },#I,#I #[fg=${ui.fg_dim}]#[bg=${ui.bg_m1}] #W }'
set-option -g window-status-current-format '#[fg=${ui.fg}]#[bg=${ui.bg_m3}]#[bold] #{?#{==:#W, },#I,#I #[fg=${modes.normal}]#[bg=${ui.bg_m1}] #W }'

# status right will show the current session name if there is more than one session
set-option -g status-right                 '#{?#{>:#{server_sessions},1}, #[fg=${diag.warning}]◆ #[fg=${ui.fg}]#{session_name} ,}'
set-option -g status-left                  ''
]],
		colors
	)
	return tmux
end

return M

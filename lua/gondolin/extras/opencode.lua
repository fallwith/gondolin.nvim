local util = require("gondolin.lib.util")

local M = {}

--- @param colors ThemeColors
function M.generate(colors)
	local opencode = util.template(
		[[
{
  "$schema": "https://opencode.ai/theme.json",
  "defs": {
    "bg": "${ui.bg}",
    "bgPanel": "${ui.bg_m2}",
    "bgElement": "${ui.bg_m1}",
    "border": "${ui.border}",
    "borderActive": "${ui.bg_p2}",
    "borderSubtle": "${ui.fg_dimmer}50",
    "text": "${ui.fg}",
    "textMuted": "${ui.fg_dim}",
    "primary": "${modes.normal}",
    "secondary": "${syn.fun}",
    "accent": "${syn.variable}",
    "error": "${diag.error}",
    "warning": "${diag.warning}",
    "success": "${diag.ok}",
    "info": "${diag.info}",
    "keyword": "${syn.keyword}",
    "function": "${syn.fun}",
    "string": "${syn.string}",
    "number": "${syn.number}",
    "comment": "${syn.comment}",
    "variable": "${syn.variable}",
    "type": "${syn.type}",
    "operator": "${syn.operator}",
    "punctuation": "${syn.punct}",
    "diffAdded": "${vcs.added}",
    "diffRemoved": "${vcs.removed}"
  },
  "theme": {
    "primary": {
      "dark": "primary",
      "light": "primary"
    },
    "secondary": {
      "dark": "secondary",
      "light": "secondary"
    },
    "accent": {
      "dark": "accent",
      "light": "accent"
    },
    "error": {
      "dark": "error",
      "light": "error"
    },
    "warning": {
      "dark": "warning",
      "light": "warning"
    },
    "success": {
      "dark": "success",
      "light": "success"
    },
    "info": {
      "dark": "info",
      "light": "info"
    },
    "text": {
      "dark": "text",
      "light": "bg"
    },
    "textMuted": {
      "dark": "textMuted",
      "light": "textMuted"
    },
    "background": {
      "dark": "bg",
      "light": "text"
    },
    "backgroundPanel": {
      "dark": "bgPanel",
      "light": "#E5E9F0"
    },
    "backgroundElement": {
      "dark": "bgElement",
      "light": "#D8DEE9"
    },
    "border": {
      "dark": "border",
      "light": "border"
    },
    "borderActive": {
      "dark": "borderActive",
      "light": "borderActive"
    },
    "borderSubtle": {
      "dark": "borderSubtle",
      "light": "borderSubtle"
    },
    "diffAdded": {
      "dark": "diffAdded",
      "light": "diffAdded"
    },
    "diffRemoved": {
      "dark": "diffRemoved",
      "light": "diffRemoved"
    },
    "diffContext": {
      "dark": "textMuted",
      "light": "textMuted"
    },
    "diffHunkHeader": {
      "dark": "textMuted",
      "light": "textMuted"
    },
    "diffHighlightAdded": {
      "dark": "diffAdded",
      "light": "diffAdded"
    },
    "diffHighlightRemoved": {
      "dark": "diffRemoved",
      "light": "diffRemoved"
    },
    "diffAddedBg": {
      "dark": "bgElement",
      "light": "#E5E9F0"
    },
    "diffRemovedBg": {
      "dark": "bgElement",
      "light": "#E5E9F0"
    },
    "diffContextBg": {
      "dark": "bgPanel",
      "light": "#E5E9F0"
    },
    "diffLineNumber": {
      "dark": "border",
      "light": "#D8DEE9"
    },
    "diffAddedLineNumberBg": {
      "dark": "bgElement",
      "light": "#E5E9F0"
    },
    "diffRemovedLineNumberBg": {
      "dark": "bgElement",
      "light": "#E5E9F0"
    },
    "markdownText": {
      "dark": "text",
      "light": "bg"
    },
    "markdownHeading": {
      "dark": "primary",
      "light": "primary"
    },
    "markdownLink": {
      "dark": "secondary",
      "light": "secondary"
    },
    "markdownLinkText": {
      "dark": "accent",
      "light": "accent"
    },
    "markdownCode": {
      "dark": "string",
      "light": "string"
    },
    "markdownBlockQuote": {
      "dark": "textMuted",
      "light": "textMuted"
    },
    "markdownEmph": {
      "dark": "${syn.special1}",
      "light": "${syn.special1}"
    },
    "markdownStrong": {
      "dark": "warning",
      "light": "warning"
    },
    "markdownHorizontalRule": {
      "dark": "textMuted",
      "light": "textMuted"
    },
    "markdownListItem": {
      "dark": "primary",
      "light": "primary"
    },
    "markdownListEnumeration": {
      "dark": "accent",
      "light": "accent"
    },
    "markdownImage": {
      "dark": "secondary",
      "light": "secondary"
    },
    "markdownImageText": {
      "dark": "accent",
      "light": "accent"
    },
    "markdownCodeBlock": {
      "dark": "text",
      "light": "bg"
    },
    "syntaxComment": {
      "dark": "comment",
      "light": "comment"
    },
    "syntaxKeyword": {
      "dark": "keyword",
      "light": "keyword"
    },
    "syntaxFunction": {
      "dark": "function",
      "light": "function"
    },
    "syntaxVariable": {
      "dark": "variable",
      "light": "variable"
    },
    "syntaxString": {
      "dark": "string",
      "light": "string"
    },
    "syntaxNumber": {
      "dark": "number",
      "light": "number"
    },
    "syntaxType": {
      "dark": "type",
      "light": "type"
    },
    "syntaxOperator": {
      "dark": "operator",
      "light": "operator"
    },
    "syntaxPunctuation": {
      "dark": "punctuation",
      "light": "punctuation"
    }
  }
}
]],
		colors
	)
	return opencode
end

return M

local M = {}

---@param colors GondolinColors
---@param opts? GondolinConfig
function M.get(colors, opts)
	opts = opts or require("gondolin.config").options
	local theme = colors.theme

	return {
		-- @variable                       various variable names
		["@variable"] = { fg = theme.syn.variable },
		-- @variable.builtin (Special)     built-in variable names (e.g. `this`, `self`)
		["@variable.builtin"] = { fg = theme.syn.constant, italic = true },
		-- @variable.parameter             parameters of a function
		["@variable.parameter"] = { fg = theme.syn.parameter },
		-- @variable.parameter.builtin     special parameters (e.g. `_`, `it`)
		-- @variable.member                object and struct fields
		["@variable.member"] = { fg = theme.syn.member },
		--
		-- @constant (Constant)              constant identifiers
		["@constant"] = { fg = theme.syn.constant },
		-- @constant.builtin       built-in constant values
		["@constant.builtin"] = { fg = theme.syn.constant, bold = true },
		-- @constant.macro         constants defined by the preprocessor
		["@constant.macro"] = { fg = theme.syn.preproc },
		--
		-- @module (Structure)      modules or namespaces
		["@module"] = { fg = theme.syn.type },
		-- @module.builtin         built-in modules or namespaces
		["@module.builtin"] = { fg = theme.syn.type, bold = true },
		-- @label                  `GOTO` and other labels (e.g. `label:` in C), including heredoc labels
		["@label"] = { fg = theme.syn.special3 },
		--
		-- @string                 string literals
		["@string"] = { fg = theme.syn.string },
		-- @string.documentation   string documenting code (e.g. Python docstrings)
		-- @string.regexp          regular expressions
		["@string.regexp"] = { fg = theme.syn.regex },
		-- @string.escape          escape sequences
		["@string.escape"] = { fg = theme.syn.regex, bold = true },
		-- @string.special         other special strings (e.g. dates)
		-- @string.special.symbol  symbols or atoms
		["@string.special.symbol"] = { fg = theme.syn.symbol },
		-- @string.special.path    filenames
		-- @string.special.url (Underlined)     URIs (e.g. hyperlinks)
		["@string.special.url"] = { link = "Underlined" },
		-- @character              character literals
		-- @character.special      special characters (e.g. wildcards)
		--
		-- @boolean                boolean literals
		["@boolean"] = { fg = theme.syn.constant, bold = true },
		-- @number                 numeric literals
		["@number"] = { fg = theme.syn.number },
		-- @number.float           floating-point number literals
		["@number.float"] = { fg = theme.syn.number },
		--
		-- @type                   type or class definitions and annotations
		["@type"] = { fg = theme.syn.type },
		-- @type.builtin           built-in types
		["@type.builtin"] = { fg = theme.syn.type, bold = true },
		-- @type.definition        identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
		["@type.definition"] = { fg = theme.syn.type },
		--
		-- @attribute              attribute annotations (e.g. Python decorators, Rust lifetimes)
		["@attribute"] = { fg = theme.syn.attribute },
		-- @attribute.builtin      builtin annotations (e.g. `@property` in Python)
		["@attribute.builtin"] = { fg = theme.syn.attribute, bold = true },
		-- @property               the key in key/value pairs
		["@property"] = { fg = theme.syn.member },
		--
		-- @function               function definitions
		["@function"] = vim.tbl_extend("force", { fg = theme.syn.fun }, opts.styles.functions),
		-- @function.builtin       built-in functions
		["@function.builtin"] = vim.tbl_extend("force", { fg = theme.syn.fun }, opts.styles.functions),
		-- @function.call          function calls
		["@function.call"] = vim.tbl_extend("force", { fg = theme.syn.fun }, opts.styles.functions),
		-- @function.macro         preprocessor macros
		["@function.macro"] = { fg = theme.syn.preproc },
		--
		-- @function.method        method definitions
		["@function.method"] = vim.tbl_extend("force", { fg = theme.syn.fun }, opts.styles.functions),
		-- @function.method.call   method calls
		["@function.method.call"] = vim.tbl_extend("force", { fg = theme.syn.fun }, opts.styles.functions),
		--
		-- @constructor            constructor calls and type instantiations
		["@constructor"] = { fg = theme.syn.type },
		-- @operator               symbolic operators (e.g. `+`, `*`)
		["@operator"] = { fg = theme.syn.operator },
		--
		-- @keyword                keywords not fitting into specific categories
		["@keyword"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.coroutine      keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		["@keyword.coroutine"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.function       keywords that define a function (e.g. `func` in Go, `def` in Python)
		["@keyword.function"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.operator       operators that are English words (e.g. `and`, `or`)
		["@keyword.operator"] = { fg = theme.syn.operator, bold = true },
		-- @keyword.import         keywords for including modules (e.g. `import`, `from` in Python)
		["@keyword.import"] = { fg = theme.syn.preproc },
		-- @keyword.type           keywords defining composite types (e.g. `struct`, `enum`)
		["@keyword.type"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.modifier       keywords defining type modifiers (e.g. `const`, `static`, `public`)
		["@keyword.modifier"] = vim.tbl_extend("force", { fg = theme.syn.statement }, opts.styles.statement),
		-- @keyword.repeat         keywords related to loops (e.g. `for`, `while`)
		["@keyword.repeat"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.return         keywords like `return` and `yield`
		["@keyword.return"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.conditional         keywords related to conditionals (e.g. `if`, `else`)
		["@keyword.conditional"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.keyword),
		-- @keyword.conditional.ternary ternary operator (e.g. `?`, `:`)
		["@keyword.conditional.ternary"] = { fg = theme.syn.operator },
		-- @keyword.debug          keywords related to debugging
		["@keyword.debug"] = vim.tbl_extend("force", { fg = theme.diag.warning }, opts.styles.keyword),
		-- @keyword.exception      keywords related to exceptions (e.g. `throw`, `catch`)
		["@keyword.exception"] = vim.tbl_extend("force", { fg = theme.syn.keyword }, opts.styles.statement),
		--
		-- @keyword.directive           various preprocessor directives and shebangs
		["@keyword.directive"] = { fg = theme.syn.preproc },
		-- @keyword.directive.define    preprocessor definition directives
		["@keyword.directive.define"] = { fg = theme.syn.preproc },
		--
		-- @punctuation.delimiter  delimiters (e.g. `;`, `.`, `,`)
		["@punctuation.delimiter"] = { fg = theme.syn.punct },
		-- @punctuation.bracket    brackets (e.g. `()`, `{}`, `[]`)
		["@punctuation.bracket"] = { fg = theme.syn.punct },
		-- @punctuation.special    special symbols (e.g. `{}` in string interpolation)
		["@punctuation.special"] = { fg = theme.syn.symbol },
		-- @comment                line and block comments
		-- @comment.documentation  comments documenting code
		-- @comment.error          error-type comments (e.g. `ERROR`, `FIXME`)
		["@comment.error"] = { fg = theme.ui.bg, bg = theme.diag.error, bold = true },
		-- @comment.warning        warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
		["@comment.warning"] = { fg = theme.ui.bg, bg = theme.diag.warning, bold = true },
		-- @comment.note           note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
		["@comment.note"] = { fg = theme.ui.bg, bg = theme.diag.hint, bold = true },
		-- @comment.todo           todo-type comments (e.g. `TODO`)
		["@comment.todo"] = { fg = theme.ui.bg, bg = theme.diag.info, bold = true },

		-- @markup.strong          bold text
		["@markup.strong"] = { bold = true },
		-- @markup.italic          italic text
		["@markup.italic"] = { italic = true },
		-- @markup.strikethrough   struck-through text
		["@markup.strikethrough"] = { strikethrough = true },
		-- @markup.underline       underlined text (only for literal underline markup!)
		["@markup.underline"] = { underline = true },
		--
		-- @markup.heading         headings, titles (including markers)
		["@markup.heading"] = { fg = theme.rainbow.rainbow1 },
		["@markup.heading.1"] = { fg = theme.rainbow.rainbow1 },
		["@markup.heading.2"] = { fg = theme.rainbow.rainbow2 },
		["@markup.heading.3"] = { fg = theme.rainbow.rainbow3 },
		["@markup.heading.4"] = { fg = theme.rainbow.rainbow4 },
		["@markup.heading.5"] = { fg = theme.rainbow.rainbow5 },
		["@markup.heading.6"] = { fg = theme.rainbow.rainbow6 },

		-- @markup.quote           block quotes
		["@markup.quote"] = { fg = theme.syn.punct },
		-- @markup.math            math environments (e.g. `$ ... $` in LaTeX)
		["@markup.math"] = { fg = theme.syn.constant },
		-- @markup.environment     environments (e.g. in LaTeX)
		["@markup.environment"] = { fg = theme.syn.keyword },
		--
		["@markup.link"] = { link = "Underlined" },
		["@markup.link.url"] = { link = "Underlined" },
		-- @markup.link.label      links in reference descriptions
		["@markup.link.label"] = { fg = theme.syn.special3, underline = false },
		-- @markup.raw             literal or verbatim text (e.g. inline code)
		["@markup.raw"] = { fg = theme.syn.string },
		-- @markup.raw.block       literal or verbatim text as a stand-alone block
		["@markup.raw.block"] = { fg = theme.syn.string },
		--
		-- @markup.list            list markers
		-- @markup.list.checked    checked todo-style list markers
		-- @markup.list.unchecked  unchecked todo-style list markers
		--
		-- @diff.plus              added text (for diff files)
		["@diff.plus"] = { fg = theme.vcs.added },
		-- @diff.minus             deleted text (for diff files)
		["@diff.minus"] = { fg = theme.vcs.removed },
		-- @diff.delta             changed text (for diff files)
		["@diff.delta"] = { fg = theme.vcs.changed },
		--
		-- @tag                    XML-style tag names (e.g. in XML, HTML, etc.)
		["@tag"] = { fg = theme.syn.special2 },
		-- @tag.builtin            XML-style tag names (e.g. HTML5 tags, svelte:head, etc.)
		["@tag.builtin"] = { fg = theme.syn.special4 },
		-- @tag.attribute          XML-style tag attributes
		["@tag.attribute"] = { fg = theme.syn.attribute },
		-- @tag.delimiter          XML-style tag delimiters
		["@tag.delimiter"] = { fg = theme.syn.punct },
	}
end

return M

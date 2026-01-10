local M = {}

function M.get(colors, opts)
	local theme = colors.theme

	return {
		NvimTreeIndentMarker = { fg = theme.ui.indent },
		NvimTreeNormal = { fg = theme.ui.fg, bg = theme.ui.sidebar.bg },
		NvimTreeNormalNC = { fg = theme.ui.fg, bg = theme.ui.sidebar.bg },
		NvimTreeCursorLine = { link = "CursorLineAlt" },
		-- Git status highlights
		NvimTreeGitDirty = { fg = theme.diag.warning },
		NvimTreeGitNew = { fg = theme.vcs.added },
		NvimTreeGitDeleted = { fg = theme.vcs.removed },
		NvimTreeGitStaged = { fg = theme.vcs.added },
		NvimTreeGitMerge = { fg = theme.diag.warning },
		NvimTreeGitRenamed = { fg = theme.diag.warning },
		NvimTreeGitIgnored = { fg = theme.ui.fg_dimmer },
		-- File-specific git highlights (HL suffix)
		NvimTreeGitFileDirtyHL = { fg = theme.diag.warning },
		NvimTreeGitFileNewHL = { fg = theme.vcs.added },
		NvimTreeGitFileDeletedHL = { fg = theme.vcs.removed },
		NvimTreeGitFileStagedHL = { fg = theme.vcs.added },
		NvimTreeGitFileMergeHL = { fg = theme.diag.warning },
		NvimTreeGitFileRenamedHL = { fg = theme.diag.warning },
		NvimTreeGitFileIgnoredHL = { fg = theme.ui.fg_dimmer },
		-- Folder-specific git highlights
		NvimTreeGitFolderDirtyHL = { fg = theme.diag.warning },
		NvimTreeGitFolderNewHL = { fg = theme.vcs.added },
		NvimTreeGitFolderDeletedHL = { fg = theme.vcs.removed },
		NvimTreeGitFolderStagedHL = { fg = theme.vcs.added },
		NvimTreeGitFolderMergeHL = { fg = theme.diag.warning },
		NvimTreeGitFolderRenamedHL = { fg = theme.diag.warning },
		NvimTreeGitFolderIgnoredHL = { fg = theme.ui.fg_dimmer },
		-- Modified buffer indicator
		NvimTreeModifiedFile = { fg = theme.diag.warning },
		NvimTreeSpecialFile = { fg = theme.ui.fg_dim },
		NvimTreeImageFile = { fg = theme.ui.fg_dim },
		NvimTreeSymlink = { fg = theme.ui.fg_dimmer },
		NvimTreeFolderName = { fg = theme.ui.fg_dim },
		NvimTreeFolderIcon = { fg = theme.ui.fg_dimmer },
		NvimTreeExecFile = { fg = theme.ui.fg },
		NvimTreeRootFolder = { fg = theme.ui.fg, bold = true },
		NvimTreeOpenedFile = { fg = theme.ui.fg, italic = true },
		NvimTreeOpenedFolderName = { fg = theme.ui.fg },
		NvimTreeOpenedFolderIcon = { fg = theme.ui.fg_dim },
		NvimTreeEmptyFolderName = { fg = theme.ui.fg_dimmer },
		NvimTreeWinSeparator = { link = "WinSeparator" },
		NvimTreeWindowPicker = { bg = theme.ui.bg_m1, fg = theme.ui.picker, bold = true },
	}
end

return M

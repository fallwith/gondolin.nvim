#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"

local local_bootstrap = ".tests/data/nvim/lazy/lazy.nvim/bootstrap.lua"
if (vim.uv or vim.loop).fs_stat(local_bootstrap) then
	dofile(local_bootstrap)
else
	local bootstrap = vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua")
	assert(vim.v.shell_error == 0 and bootstrap ~= "", "failed to fetch lazy.nvim bootstrap")
	assert(load(bootstrap))()
end

-- Setup lazy
require("lazy.minit").setup({
	spec = {
		{
			dir = vim.uv.cwd(),
			opts = {},
		},
	},
	rocks = {
		hererocks = false,
	},
})

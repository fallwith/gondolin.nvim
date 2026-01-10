#!/bin/bash
set -e

nvim -u scripts/minit.lua --headless +"lua require('gondolin.extras').setup()" +qa

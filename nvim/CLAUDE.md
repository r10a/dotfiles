# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration repository. The entry point is `init.lua`. Neovim loads this config from `~/.config/nvim/` (or wherever `XDG_CONFIG_HOME` points), so this repo should be symlinked or cloned there.

## Structure

- `init.lua` — main config: options, leader key, keymaps, and lazy.nvim bootstrap
- `lua/plugins/` — plugin specs for lazy.nvim (one file per plugin)

## Conventions

- Leader key is Space
- Indentation: 4 spaces (matches the config's own `shiftwidth`/`tabstop`)
- Config is written in Lua (not Vimscript)
- Use `vim.opt` for options, `vim.keymap.set` for mappings, `vim.api` for lower-level APIs

## Testing changes

Open Neovim to verify config changes work:
```
nvim --clean -u init.lua
```

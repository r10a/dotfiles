# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the Neovim configuration, kept in the `nvim/` subfolder of the personal dotfiles repo (`github.com/r10a/dotfiles`). The entry point is `init.lua`. Neovim loads this config from `~/.config/nvim/`, which is a symlink to `~/dotfiles/nvim/` — edit via either path, but run `git` from `~/dotfiles`.

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

# Neovim Configuration

## Shortcuts

### Buffers
| Key | Action |
|-----|--------|
| `Space ]` | Next buffer |
| `Space [` | Previous buffer |
| `Space 1-9` | Jump to buffer by number |
| `Space q` | Close buffer |

### Splits
| Key | Action |
|-----|--------|
| `Space h` | Horizontal split |
| `Space v` | Vertical split |
| `Space Left` | Move to left split |
| `Space Down` | Move to below split |
| `Space Up` | Move to above split |
| `Space Right` | Move to right split |

### Workspace
| Key | Action |
|-----|--------|
| `Space n` | New workspace |
| `Space w` | Close workspace |
| `Space Q` | Quit all |

### File Navigation
| Key | Action |
|-----|--------|
| `Space e` | Toggle file tree (floating) |
| `Space f` | Find files |
| `Space g` | Live grep (excludes node_modules, .git) |
| `Space b` | Find buffers |
| `Space ?` | Search keybinds |

### Git
| Key | Action |
|-----|--------|
| `Space gg` | Neogit status |
| `Space gc` | Neogit commit |
| `Space gp` | Neogit push |
| `Space gl` | Neogit pull |
| `Space gb` | Neogit branch |

### Misc
| Key | Action |
|-----|--------|
| `Space s` | Open scratchpad |
| `Space r` | Reload config |

### CopyReference (LLM context review)
Stage code selections with prompts into a review, then copy the whole bundle
(as XML) for pasting to an LLM. See "Local modules" below.

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | visual | Add selection to the review (asks for a per-item prompt) |
| `Tab Tab` | normal | Open the Review window |
| `<CR>` | in Review | Copy the whole review to clipboard & clear |
| `dd` | in Review | Delete the item under the cursor |
| `r` | in Review | Re-prompt the item (shows its code as context) |
| `?` | in Review | Show the keybinding help |
| `Tab Tab` / `Esc` | in Review | Close the Review |

### Markdown tables
| Key | Mode | Action |
|-----|------|--------|
| `Space te` | normal | Enter interactive table editing (pipetable) |

## Plugins

- **bufferline.nvim** — buffer tabs with ordinal numbers
- **scope.nvim** — scopes buffers to workspaces (tabs)
- **nvim-tree.lua** — floating file tree explorer
- **telescope.nvim** — fuzzy finder for files, grep, and buffers
- **telescope-fzf-native.nvim** — fast fzf sorting for telescope
- **neogit** — git interface (with diffview integration)
- **diffview.nvim** — side-by-side diff viewer
- **auto-session** — auto-save/restore workspace per directory
- **render-markdown.nvim** — in-editor markdown rendering (its own table
  renderer is disabled; tables are handled by pipetable)
- **markdown-pipetable.nvim** — interactive, fit-to-width markdown tables with
  cell-by-cell editing (`auto_enter` off; enter with `Space te`)
- **nvim-treesitter** — syntax parsing for highlighting and rendering
- **nvim-web-devicons** — file type icons

## Local modules

- **copyreference** (`lua/copyreference/`) — stage code selections + per-item
  prompts into a *review*, then copy the whole bundle for pasting to LLMs. In
  XML mode each entry is a self-contained `<item>` (file + prompt). Visual
  `<CR>` adds the selection;
  a live panel shows staged items at the bottom-right. `Tab Tab` opens the
  Review, where `<CR>` copies+clears, `dd` deletes, `r` re-prompts (with the
  code shown as context), and `?` shows help. Paths are git-root-relative when
  in a repo. Configured in `init.lua` via `setup()`; options: `register`,
  `use_git_root`, `include_code`, `output_style` (`"markdown"` or `"xml"` —
  currently `xml`).

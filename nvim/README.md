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
| `Space yr` | Yank line/selection as XML with `file:line` ref (for LLMs) |
| `Space r` | Reload config |

## Plugins

- **bufferline.nvim** — buffer tabs with ordinal numbers
- **scope.nvim** — scopes buffers to workspaces (tabs)
- **nvim-tree.lua** — floating file tree explorer
- **telescope.nvim** — fuzzy finder for files, grep, and buffers
- **telescope-fzf-native.nvim** — fast fzf sorting for telescope
- **neogit** — git interface (with diffview integration)
- **diffview.nvim** — side-by-side diff viewer
- **auto-session** — auto-save/restore workspace per directory
- **render-markdown.nvim** — in-editor markdown rendering
- **nvim-treesitter** — syntax parsing for highlighting and rendering
- **nvim-web-devicons** — file type icons

## Local modules

- **copyreference** (`lua/copyreference/`) — yank a `file:line` reference with
  the code, formatted for pasting to LLMs. Bound to `Space yr` (line in normal
  mode, selection in visual mode) and also exposed as `:CopyReference`
  (respects a `:'<,'>` range). Paths are git-root-relative when in a repo.
  Configured in `init.lua` via `setup()`; options: `register`, `use_git_root`,
  `include_code`, `output_style` (`"markdown"` or `"xml"` — currently `xml`).

# Neovim Configuration

## Shortcuts

### Buffers
| Key | Action |
|-----|--------|
| `Space ]` | Next buffer |
| `Space [` | Previous buffer |
| `Space q` | Close buffer |

Buffer tabs are Neovim's native tabline, which shows only when 2+ tabs are open.

### Tabs
| Key | Action |
|-----|--------|
| `Space t q` | Close tab |

### Splits
| Key | Action |
|-----|--------|
| `Space h` | Horizontal split |
| `Space v` | Vertical split |
| `Space Left` | Move to left split |
| `Space Down` | Move to below split |
| `Space Up` | Move to above split |
| `Space Right` | Move to right split |
| `Space Q` | Quit all |

### File Navigation
| Key | Action |
|-----|--------|
| `Space e` | Toggle file tree (docked right, auto-width) |
| `Space f` | Find files |
| `Space g` | Live grep (excludes node_modules, .git) |
| `Space b` | Find buffers |
| `Space ?` | Search keybinds |

`nvim <dir>` (e.g. `vi .`) opens an empty buffer with the tree docked beside it, cursor left in the editor.

### LSP
Native `vim.lsp` client (Neovim 0.11+). rust-analyzer runs through the rustup
proxy, so it does not need to be on `PATH`.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `grr` | References (native default) |
| `gra` | Code action (native default) |
| `grn` | Rename (native default) |
| `K` | Hover docs (native default) |

### Misc
| Key | Action |
|-----|--------|
| `Space s` | Open scratchpad |
| `Space r` | Reload config |
| `s` | Jump to a location on screen (nvim-jump; overrides substitute) |
| `Esc Esc` | Clear search highlight |
| `Ctrl-v` (insert) | Switch to visual mode (overrides insert-literal) |

### prompt-reference (LLM context review)
Stage code selections with prompts into a review, then send the whole bundle
(as XML) straight into the tmux pane running Claude Code (`sink = "tmux"`;
auto-detects the pane, falls back to the clipboard if none is found). Provided by
[prompt-reference.nvim](https://github.com/r10a/prompt-reference.nvim).

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | visual | Add selection to the review (asks for a per-item prompt) |
| `Tab Tab` | normal | Open the Review window |
| `<CR>` | in Review | Send the whole review to the claude tmux pane & clear |
| `dd` | in Review | Delete the item under the cursor |
| `r` | in Review | Re-prompt the item (shows its code as context) |
| `?` | in Review | Show the keybinding help |
| `Tab Tab` / `Esc` | in Review | Close the Review |

## Plugins

- **kanagawa.nvim** - colorscheme (wave variant)
- **nvim-jump** - label-based on-screen motion (press `s`, type a match, jump)
- **nvim-tree.lua** - file tree explorer docked on the right, auto-sizing to the
  longest visible name (min 30 columns, unbounded max, so names never clip)
- **which-key.nvim** - popup showing follow-up keys as you type a prefix
- **neoscroll.nvim** - smooth scrolling
- **smear-cursor.nvim** - animated cursor trail
- **telescope.nvim** — fuzzy finder for files, grep, and buffers
- **telescope-fzf-native.nvim** — fast fzf sorting for telescope
- **auto-session** — auto-save/restore workspace per directory
- **render-markdown.nvim** — in-editor markdown rendering (table rendering left
  off; tables show as plain aligned source, since `wrap` breaks pipe tables)
- **nvim-treesitter** — syntax parsing for highlighting and rendering
- **nvim-web-devicons** — file type icons
- **prompt-reference.nvim** — stage code selections + per-item prompts into a
  review, then copy the bundle (XML) for pasting to LLMs (own repo:
  [r10a/prompt-reference.nvim](https://github.com/r10a/prompt-reference.nvim))

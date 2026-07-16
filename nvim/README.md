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
| `s` | Jump to a location on screen (nvim-jump; overrides substitute) |
| `Esc Esc` | Clear search highlight |
| `Ctrl-v` (insert) | Switch to visual mode (overrides insert-literal) |

### prompt-reference (LLM context review)
Stage code selections with prompts into a review, then copy the whole bundle
(as XML) for pasting to an LLM. Provided by
[prompt-reference.nvim](https://github.com/r10a/prompt-reference.nvim).

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | visual | Add selection to the review (asks for a per-item prompt) |
| `Tab Tab` | normal | Open the Review window |
| `<CR>` | in Review | Copy the whole review to clipboard & clear |
| `dd` | in Review | Delete the item under the cursor |
| `r` | in Review | Re-prompt the item (shows its code as context) |
| `?` | in Review | Show the keybinding help |
| `Tab Tab` / `Esc` | in Review | Close the Review |

## Plugins

- **kanagawa.nvim** - colorscheme (wave variant)
- **nvim-jump** - label-based on-screen motion (press `s`, type a match, jump)
- **bufferline.nvim** — buffer tabs with ordinal numbers
- **scope.nvim** — scopes buffers to workspaces (tabs)
- **nvim-tree.lua** — floating file tree explorer
- **telescope.nvim** — fuzzy finder for files, grep, and buffers
- **telescope-fzf-native.nvim** — fast fzf sorting for telescope
- **neogit** — git interface (with diffview integration)
- **diffview.nvim** — side-by-side diff viewer
- **auto-session** — auto-save/restore workspace per directory
- **render-markdown.nvim** — in-editor markdown rendering (table rendering left
  off; tables show as plain aligned source, since `wrap` breaks pipe tables)
- **nvim-treesitter** — syntax parsing for highlighting and rendering
- **nvim-web-devicons** — file type icons
- **prompt-reference.nvim** — stage code selections + per-item prompts into a
  review, then copy the bundle (XML) for pasting to LLMs (own repo:
  [r10a/prompt-reference.nvim](https://github.com/r10a/prompt-reference.nvim))

# dotfiles

Personal configuration files, organized one folder per tool.

## Layout

```
dotfiles/
  nvim/            ->  ~/.config/nvim/
  tmux/tmux.conf   ->  ~/.config/tmux/tmux.conf
  AGENTS.md        ->  ~/AGENTS.md  and  ~/CLAUDE.md
```

Configs are symlinked into place. `AGENTS.md` holds global agent
instructions; `~/CLAUDE.md` is a second symlink to the same file.

## Setup on a new machine

```sh
git clone <this-repo> ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/AGENTS.md ~/AGENTS.md
ln -s ~/dotfiles/AGENTS.md ~/CLAUDE.md
```

## Recommended Claude Code plugins

Not symlinked (Claude Code manages plugin state itself). Install with
`claude plugin install <plugin>@<marketplace>`:

| Plugin | Marketplace | Repo |
| --- | --- | --- |
| `example-skills` | `anthropic-agent-skills` | `anthropics/skills` |
| `ponytail` | `ponytail` | `DietrichGebert/ponytail` |
| `keep-awake` | `claude-community` | `anthropics/claude-plugins-community` |

Add a marketplace first if it's unknown:
`claude plugin marketplace add <repo>`.

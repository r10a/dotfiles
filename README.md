# dotfiles

Personal configuration files, organized one folder per tool.

## Layout

```
dotfiles/
  nvim/                 ->  ~/.config/nvim/
  tmux/tmux.conf        ->  ~/.config/tmux/tmux.conf
  wezterm/wezterm.lua   ->  ~/.wezterm.lua
  starship/starship.toml->  ~/.config/starship.toml
  zsh/zshrc             ->  ~/.zshrc
  AGENTS.md             ->  ~/AGENTS.md  and  ~/CLAUDE.md
```

`~/.zshrc` sources `~/.zshrc.local` (untracked) for machine-local secrets like
work credentials - keep those out of this repo.


Configs are symlinked into place. `AGENTS.md` holds global agent
instructions; `~/CLAUDE.md` is a second symlink to the same file.

## Setup on a new machine

Install the tools (macOS, Homebrew). `install.sh` also installs starship and
zoxide automatically:

```sh
brew install --cask wezterm font-meslo-lg-nerd-font
brew install starship zoxide
```

Then clone and symlink:

```sh
git clone <this-repo> ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/AGENTS.md ~/AGENTS.md
ln -s ~/dotfiles/AGENTS.md ~/CLAUDE.md
```

`zsh/zshrc` initializes starship and zoxide automatically (guarded, so a machine
without them still gets a working shell).

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

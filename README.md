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
  AGENTS.md             ->  ~/AGENTS.md, ~/CLAUDE.md, ~/.codex/AGENTS.md
```

`~/.zshrc` sources `~/.zshrc.local` (untracked) for machine-local secrets like
work credentials - keep those out of this repo.

Configs are symlinked into place. `AGENTS.md` holds global agent instructions;
`~/CLAUDE.md` (Claude Code) and `~/.codex/AGENTS.md` (Codex) are symlinks to the
same file, so both agents read one set of rules.

## Setup on a new machine

```sh
git clone <this-repo> ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` installs everything the configs need if it is missing - neovim,
tmux, fzf, starship, zoxide, node, Claude Code,
[treehouse](https://github.com/kunchenguid/treehouse), and the agent skills -
then creates the symlinks. Safe to re-run.

WezTerm and its font are the one exception (GUI app, macOS only):

```sh
brew install --cask wezterm font-meslo-lg-nerd-font
```

To symlink by hand instead:

```sh
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/AGENTS.md ~/AGENTS.md
ln -s ~/dotfiles/AGENTS.md ~/CLAUDE.md
ln -s ~/dotfiles/AGENTS.md ~/.codex/AGENTS.md
```

`zsh/zshrc` initializes starship and zoxide automatically (guarded, so a machine
without them still gets a working shell).

## Worktrees

[treehouse](https://github.com/kunchenguid/treehouse) manages a pool of reusable
git worktrees so parallel agents get isolated checkouts without losing their
dependencies and build cache. `treehouse` drops you into one; `exit` returns it.
`AGENTS.md` documents the non-interactive `get --lease` / `return` cycle so agents
use the pool instead of `git worktree add`.

## Agent skills and plugins

Not symlinked (Claude Code manages plugin state itself). `install.sh` installs
`mattpocock-skills` automatically; add the rest with
`claude plugin install <plugin>@<marketplace>`:

| Plugin | Marketplace | Repo |
| --- | --- | --- |
| `example-skills` | `anthropic-agent-skills` | `anthropics/skills` |
| `ponytail` | `ponytail` | `DietrichGebert/ponytail` |
| `keep-awake` | `claude-community` | `anthropics/claude-plugins-community` |
| `mattpocock-skills` | `claude-plugins-official` | `mattpocock/skills` |

Add a marketplace first if it's unknown:
`claude plugin marketplace add <repo>`.

`install.sh` installs `mattpocock/skills` for both agents: the Claude Code plugin
above, and the same skills for Codex via `npx skills@latest add` into
`~/.agents/skills/` (global, so it does not double up with the plugin inside a
repo). Run `/setup-matt-pocock-skills` once per repo to pick your issue tracker
and doc locations.

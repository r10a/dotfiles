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

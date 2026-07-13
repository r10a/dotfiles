# dotfiles

Personal configuration files, organized one folder per tool.

## Layout

```
dotfiles/
  tmux/tmux.conf   ->  ~/.config/tmux/tmux.conf
```

Each folder is symlinked into `~/.config/`.

## Setup on a new machine

```sh
git clone <this-repo> ~/dotfiles
ln -s ~/dotfiles/tmux ~/.config/tmux
```

## Notes

- Neovim lives in its own repo (github.com/r10a/nvim) at `~/.config/nvim` and is
  intentionally not tracked here.

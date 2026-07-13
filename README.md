# dotfiles

Personal configuration files, organized one folder per tool.

## Layout

```
dotfiles/
  nvim/            ->  ~/.config/nvim/
  tmux/tmux.conf   ->  ~/.config/tmux/tmux.conf
```

Each folder is symlinked into `~/.config/`.

## Setup on a new machine

```sh
git clone <this-repo> ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux
```

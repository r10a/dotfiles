#!/usr/bin/env bash
# Idempotent dotfiles installer.
#
# Works on a fresh machine or a GitHub Codespace: installs neovim + tmux if
# missing, then symlinks the configs into place (per README.md). Safe to re-run;
# existing real files are backed up to <path>.bak before being replaced.
#
# GitHub Codespaces runs this automatically when this repo is set as your
# dotfiles repo (Settings -> Codespaces -> Automatically install dotfiles).
set -euo pipefail

# Resolve this repo's location from the script path, so it works whether cloned
# to ~/dotfiles, the Codespaces dotfiles mount, or anywhere else.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m[dotfiles]\033[0m %s\n' "$*"; }

# --- link helper: back up an existing real target, then symlink -------------
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  # Already the correct symlink? Nothing to do.
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "ok    $dst"
    return
  fi
  # Real file/dir in the way: preserve it.
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    log "backup $dst -> $dst.bak"
    rm -rf "$dst.bak"
    mv "$dst" "$dst.bak"
  fi
  rm -f "$dst"
  ln -s "$src" "$dst"
  log "link  $dst -> $src"
}

# --- install neovim + tmux if absent ----------------------------------------
# Debian/Ubuntu ship an old neovim (too old for lazy.nvim), so fetch the
# official static build for neovim; use the distro package for tmux.
install_neovim() {
  command -v nvim >/dev/null 2>&1 && { log "neovim present: $(nvim --version | head -1)"; return; }
  log "installing neovim (official stable build)"
  local arch asset url tmp
  case "$(uname -m)" in
    x86_64)  arch="x86_64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) log "unknown arch $(uname -m); skipping neovim"; return ;;
  esac
  tmp="$(mktemp -d)"
  # Asset name changed across releases; try the current name then the legacy one.
  for asset in "nvim-linux-${arch}.tar.gz" "nvim-linux64.tar.gz"; do
    url="https://github.com/neovim/neovim/releases/download/stable/${asset}"
    if curl -fsSL "$url" -o "$tmp/nvim.tar.gz"; then
      tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"
      sudo rm -rf /opt/nvim
      sudo mv "$tmp"/nvim-linux* /opt/nvim
      sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
      log "neovim installed: $(nvim --version | head -1)"
      rm -rf "$tmp"
      return
    fi
  done
  log "WARN: could not download neovim; leaving it to you"
  rm -rf "$tmp"
}

install_tmux() {
  command -v tmux >/dev/null 2>&1 && { log "tmux present: $(tmux -V)"; return; }
  if command -v apt-get >/dev/null 2>&1; then
    log "installing tmux (apt)"
    sudo apt-get update -qq && sudo apt-get install -y -qq tmux
  else
    log "WARN: no apt-get; install tmux yourself"
  fi
}

install_neovim
install_tmux

# --- symlinks (see README.md) -----------------------------------------------
link "$DOTFILES_DIR/nvim"       "$HOME/.config/nvim"
link "$DOTFILES_DIR/tmux"       "$HOME/.config/tmux"
link "$DOTFILES_DIR/AGENTS.md"  "$HOME/AGENTS.md"
link "$DOTFILES_DIR/AGENTS.md"  "$HOME/CLAUDE.md"

log "done. Launch nvim once to let lazy.nvim sync plugins."

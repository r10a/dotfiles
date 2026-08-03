#!/usr/bin/env bash
# Idempotent dotfiles installer.
#
# Works on a fresh machine or a GitHub Codespace: installs every tool the configs
# need if it is missing, then symlinks the configs into place (per README.md).
# Safe to re-run; existing real files are backed up to <path>.bak first.
#
# GitHub Codespaces runs this automatically when this repo is set as your
# dotfiles repo (Settings -> Codespaces -> Automatically install dotfiles).
set -euo pipefail

# Resolve this repo's location from the script path, so it works whether cloned
# to ~/dotfiles, the Codespaces dotfiles mount, or anywhere else.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m[dotfiles]\033[0m %s\n' "$*"; }

# treehouse and claude install here; make them visible to later steps in this run.
export PATH="$HOME/.local/bin:$PATH"

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

# --- tools: install if absent, prefer brew, else the distro/official installer -
# Debian/Ubuntu ship an old neovim (too old for lazy.nvim), so fetch the official
# static build there.
install_neovim() {
  command -v nvim >/dev/null 2>&1 && { log "neovim present: $(nvim --version | head -1)"; return; }
  if command -v brew >/dev/null 2>&1; then
    log "installing neovim (brew)"; brew install neovim; return
  fi
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
  if command -v brew >/dev/null 2>&1; then
    log "installing tmux (brew)"; brew install tmux
  elif command -v apt-get >/dev/null 2>&1; then
    log "installing tmux (apt)"
    sudo apt-get update -qq && sudo apt-get install -y -qq tmux
  else
    log "WARN: no brew or apt-get; install tmux yourself"
  fi
}

# zsh/zshrc sources `fzf --zsh` on its first line, so a missing fzf breaks the shell.
install_fzf() {
  command -v fzf >/dev/null 2>&1 && { log "fzf present: $(fzf --version)"; return; }
  if command -v brew >/dev/null 2>&1; then
    log "installing fzf (brew)"; brew install fzf
  elif command -v apt-get >/dev/null 2>&1; then
    log "installing fzf (apt)"
    sudo apt-get update -qq && sudo apt-get install -y -qq fzf
  else
    log "WARN: no brew or apt-get; install fzf yourself"
  fi
}

# starship (prompt) + zoxide (smart cd). Prefer brew on macOS; fall back to the
# official curl installers on Linux boxes without brew.
install_starship() {
  command -v starship >/dev/null 2>&1 && { log "starship present: $(starship --version | head -1)"; return; }
  if command -v brew >/dev/null 2>&1; then
    log "installing starship (brew)"; brew install starship
  else
    log "installing starship (curl)"; curl -fsSL https://starship.rs/install.sh | sh -s -- -y
  fi
}

install_zoxide() {
  command -v zoxide >/dev/null 2>&1 && { log "zoxide present: $(zoxide --version)"; return; }
  if command -v brew >/dev/null 2>&1; then
    log "installing zoxide (brew)"; brew install zoxide
  else
    log "installing zoxide (curl)"; curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
}

install_treehouse() {
  command -v treehouse >/dev/null 2>&1 && { log "treehouse present: $(treehouse --version 2>&1 | head -1)"; return; }
  log "installing treehouse (curl)"; curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | sh
}

# node ships npx, which the skills CLI needs.
install_node() {
  command -v npx >/dev/null 2>&1 && { log "node present: $(node --version)"; return; }
  if command -v brew >/dev/null 2>&1; then
    log "installing node (brew)"; brew install node
  elif command -v apt-get >/dev/null 2>&1; then
    log "installing node 22 (nodesource)"
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt-get install -y -qq nodejs
  else
    log "WARN: no brew or apt-get; install node yourself"
  fi
}

install_claude() {
  command -v claude >/dev/null 2>&1 && { log "claude present: $(claude --version)"; return; }
  log "installing claude code (curl)"; curl -fsSL https://claude.ai/install.sh | bash
}

# mattpocock/skills for both agents: the Claude Code plugin (managed, auto-updating)
# and the skills CLI for Codex. Never both in one repo - you get every skill twice.
install_agent_skills() {
  log "installing mattpocock-skills (claude plugin)"
  claude plugin install mattpocock-skills@claude-plugins-official
  log "installing mattpocock/skills (codex, global)"
  npx -y skills@latest add mattpocock/skills --global --agent codex --skill '*' -y
}

install_neovim
install_tmux
install_fzf
install_starship
install_zoxide
install_treehouse
install_node
install_claude
install_agent_skills

# --- symlinks (see README.md) -----------------------------------------------
link "$DOTFILES_DIR/nvim"                  "$HOME/.config/nvim"
link "$DOTFILES_DIR/tmux"                  "$HOME/.config/tmux"
link "$DOTFILES_DIR/wezterm/wezterm.lua"   "$HOME/.wezterm.lua"
link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/zsh/zshrc"             "$HOME/.zshrc"
link "$DOTFILES_DIR/AGENTS.md"             "$HOME/AGENTS.md"
link "$DOTFILES_DIR/AGENTS.md"             "$HOME/CLAUDE.md"
link "$DOTFILES_DIR/AGENTS.md"             "$HOME/.codex/AGENTS.md"

log "done. Launch nvim once to let lazy.nvim sync plugins."
log "run /setup-matt-pocock-skills once per repo to configure the skills."

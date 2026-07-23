#!/usr/bin/env bash
# lumentae's dotfiles bootstrap
# Run this after NixOS is installed:
#   sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/lumentae/dots/main/scripts/bootstrap.sh)"
set -euo pipefail

REPO="https://github.com/lumentae/dots"
BRANCH="main"

info()  { printf "\033[32m  [INFO]\033[0m %s\n" "$*"; }
warn()  { printf "\033[33m  [WARN]\033[0m %s\n" "$*"; }
error() { printf "\033[31m  [ERROR]\033[0m %s\n" "$*"; exit 1; }

# --- Determine host ---
if [ -z "${HOST:-}" ]; then
  if lspci 2>/dev/null | grep -qi nvidia; then
    HOST="lumentae-desktop"
  else
    HOST="lumentae-laptop"
  fi
  info "Using host: $HOST (set HOST=... to override)"
fi

# --- Preflight ---
[ "$EUID" -eq 0 ] || error "Run as root"
[ -f /etc/NIXOS ] || error "Not a live NixOS system"

# --- Get git ---
if command -v git &>/dev/null; then
  GIT=(git)
else
  NIX_BIN="$(command -v nix || echo /run/current-system/sw/bin/nix)"
  if [[ ! -x "$NIX_BIN" ]]; then
    error "nix binary not found at expected NixOS location ($NIX_BIN)"
    exit 1
  fi
  info "git not found — using nix shell to run git"
  GIT=(env NIX_CONFIG='experimental-features = nix-command flakes' "$NIX_BIN" shell nixpkgs#git -c git)
fi

# --- Clone/pull dots repo ---
DOTS="/home/lumentae/dots"
NIX_DIR="$DOTS/nix"

if [ -d "$NIX_DIR/.git" ]; then
  warn "Dotfiles already exist at $DOTS — pulling latest"
  "${GIT[@]}" -C "$DOTS" pull
else
  info "Cloning dotfiles to $DOTS"
  mkdir -p "$(dirname "$DOTS")"
  "${GIT[@]}" clone --branch "$BRANCH" "$REPO" "$DOTS"
fi

# --- Generate hardware config alongside the flake ---
HW_CONFIG="$NIX_DIR/hosts/$HOST/hardware-configuration.nix"
if [ ! -f "$HW_CONFIG" ]; then
  info "Generating hardware configuration"
  nixos-generate-config --dir "$NIX_DIR/hosts/$HOST"
fi

# --- Apply flake configuration ---
info "Applying NixOS configuration"
nixos-rebuild switch --flake "$NIX_DIR#$HOST" --show-trace
info "Bootstrap complete!"

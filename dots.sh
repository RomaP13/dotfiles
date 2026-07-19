#!/usr/bin/env bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_CONFIG="$HOME/.config"

log() {
  printf '==> %s\n' "$*"
}

link() {
  log "Linking $2"
  ln -sfn "$1" "$2"
}

unlink() {
  local path="$1"

  if [[ -L "$path" ]]; then
    log "Unlinking $path"
    rm "$path"
  elif [[ -e "$path" ]]; then
    log "$path exists but is not a symlink."
    return 1
  else
    log "$path is already absent."
  fi
}

config_action() {
  local action="$1"
  local app="$2"

  local src="$DOTFILES/.config/$app"
  local dst="$HOME/.config/$app"

  case "$action" in
    link)
      if [[ ! -d "$DOTFILES/.config/$app" ]]; then
        log "Config '$app' does not exist."
        exit 1
      fi

      mkdir -p "$HOME_CONFIG"

      link "$src" "$dst"
      ;;
    unlink)
      unlink "$dst"
      ;;
  esac
}

bin_action() {
    local action="$1"
    local script="$2"

    local src="$DOTFILES/.local/bin/$script"
    local dst="$HOME/.local/bin/$script"

    mkdir -p "$HOME/.local/bin"

    case "$action" in
        link)
            link "$src" "$dst"
            ;;
        unlink)
            unlink "$dst"
            ;;
    esac
}

all_configs_action() {
  local action="$1"

  mkdir -p "$HOME_CONFIG"

  for src in "$DOTFILES/.config"/*; do
    [[ -d "$src" ]] || continue

    local app="$(basename "$src")"
    local dst="$HOME_CONFIG/$app"

    case "$action" in
      link)
        link "$src" "$dst"
        ;;
      unlink)
        unlink "$dst"
        ;;
    esac
  done
}

special_action() {
  local action="$1"

  case "$2" in
    .bashrc)
      case "$action" in
        link)
          link "$DOTFILES/.bashrc" "$HOME/.bashrc"
        ;;
        unlink)
          unlink "$HOME/.bashrc"
        ;;
      esac
      ;;
    .zshrc)
      case "$action" in
        link)
          link "$DOTFILES/.zshrc" "$HOME/.zshrc"
        ;;
        unlink)
          unlink "$HOME/.zshrc"
        ;;
      esac
      ;;
    wallpapers)
      case "$action" in
        link)
          mkdir -p "$HOME/Pictures/wallpapers"
          link "$DOTFILES/wallpapers" "$HOME/Pictures/wallpapers"
        ;;
        unlink)
          unlink "$HOME/Pictures/wallpapers"
        ;;
      esac
      ;;
  esac
}

usage() {
  cat <<EOF
Usage:
  $0 link all
  $0 link kitty
  $0 unlink kitty
  $0 link .bashrc
EOF
}

main() {
  [[ $# -eq 2 ]] || {
    usage
    exit 1
  }

  local action="$1"
  local target="$2"

  case "$action" in
    link|unlink) ;;
    *)
      log "Unknown action: $action"
      exit 1
      ;;
  esac

  if [[ -d "$DOTFILES/.config/$target" ]]; then
    config_action "$action" "$target"
  elif [[ -f "$DOTFILES/.local/bin/$target" ]]; then
    bin_action "$action" "$target"
  else
    case "$target" in
      .bashrc|.zshrc|wallpapers)
        special_action "$action" "$target"
        ;;
    esac
  fi
}

main "$@"

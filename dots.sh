#!/usr/bin/env bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

log() {
  printf '==> %s\n' "$*"
}

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  # Auto-chmod scripts
  if [[ "$src" == *"/.local/scripts/"* && -f "$src" ]]; then
    log "Making $src executable"
    chmod +x "$src"
  fi

  log "Linking $dst -> $src"
  ln -sfn "$src" "$dst"
}

unlink() {
  local dst="$1"

  if [[ -L "$dst" ]]; then
    log "Unlinking $dst"
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    log "$dst exists but is not a symlink."
    return 1
  else
    log "$dst is already absent."
  fi
}

process_rel() {
  local action="$1"
  local rel_path="$2"

  # Handle special destination overrides
  local dst_path="$rel_path"
  if [[ "$rel_path" == "wallpapers" ]]; then
    dst_path="Pictures/wallpapers"
  fi

  local src="$DOTFILES/$rel_path"
  local dst="$HOME_DIR/$dst_path"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    log "Source '$src' does not exist."
    return 1
  fi

  case "$action" in
    link) link "$src" "$dst" ;;
    unlink) unlink "$dst" ;;
  esac
}

resolve_and_process() {
  local action="$1"
  local target="$2"

  # 1. Exact relative path match (e.g. .zshrc, .local/scripts/brightness)
  if [[ -e "$DOTFILES/$target" ]]; then
    process_rel "$action" "$target"
    return
  fi

  # 2. Direct directory shortcut
  case "$target" in
    scripts)
      process_rel "$action" ".local/scripts"
      return
      ;;
    share)
      process_rel "$action" ".local/share"
      return
      ;;
  esac

  # 3. Check inside .config/ (e.g. 'kitty', 'nvim')
  if [[ -e "$DOTFILES/.config/$target" ]]; then
    process_rel "$action" ".config/$target"
    return
  fi

  # 4. Check inside .local/scripts/ (e.g. 'random_wallpaper' or 'scripts')
  if [[ -e "$DOTFILES/.local/scripts/$target" ]]; then
    process_rel "$action" ".local/scripts/$target"
    return
  fi

  # 5. Check inside .local/share/ (e.g. 'applications')
  if [[ -e "$DOTFILES/.local/share/$target" ]]; then
    process_rel "$action" ".local/share/$target"
    return
  fi

  # 6. Handle 'all'
  if [[ "$target" == "all" ]]; then
    process_all "$action"
    return
  fi

  log "Target '$target' not found in dotfiles."
  exit 1
}

usage() {
  cat << EOF
Usage:
  $0 link <target>
  $0 unlink <target>

Examples:
  $0 link all                         # Links everything
  $0 link scripts                     # Links whole ~/.local/scripts directory
  $0 link brightness                  # Links single script inside ~/.local/scripts/
  $0 link applications                # Links ~/.local/share/applications
  $0 link kitty                       # Links ~/.config/kitty
  $0 link .zshrc                      # Links ~/.zshrc
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
    link | unlink) ;;
    *)
      log "Unknown action: $action"
      exit 1
      ;;
  esac

  resolve_and_process "$action" "$target"
}

main "$@"

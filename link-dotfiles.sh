#!/bin/bash

set -e  # Stop on errors

DOTFILES_DIR="$(pwd)"
TARGET_DIR="$HOME"

# Ignore patterns
IGNORED_FILES=(
  ".git"
  ".gitignore"
  ".gitmodules"
  ".gitattributes"
)

should_ignore() {
  for ignore in "${IGNORED_FILES[@]}"; do
    [[ "$1" == "$ignore" ]] && return 0
  done
  return 1
}

link_dir() {
  local src_root="$1"
  local target_root="$2"

  find "$src_root" -mindepth 1 -maxdepth 1 | while read -r src_path; do
    local name="$(basename "$src_path")"
    local dest_path="$target_root/$name"

	[[ "$name" == "." || "$name" == ".." ]] && continue
    # Ignore git-related files
    should_ignore "$name" && continue

    if [ -e "$dest_path" ] && [ ! -L "$dest_path" ]; then
      echo "⚠️  Removing existing non-symlink: $dest_path"
      rm -rf "$dest_path"
    fi

    echo "Linking $src_path -> $dest_path"
    ln -sfn "$src_path" "$dest_path"
  done
}

# --- Link top-level dotfiles and dotdirs ---
find . -maxdepth 1 \( -type f -o -type d \) | while read -r file; do
  name="$(basename "$file")"
  [[ "$name" == "." || "$name" == ".." ]] && continue
  should_ignore "$name" && continue

  src="$DOTFILES_DIR/$name"
  dest="$HOME/$name"

  echo "🔗 Linking $src -> $dest"
  ln -sfn "$src" "$dest"
done

# --- Link ~/.config/<subdirs> ---
if [ -d "$DOTFILES_DIR/.config" ]; then
  mkdir -p "$HOME/.config"
  link_dir "$DOTFILES_DIR/.config" "$HOME/.config"
fi

# --- Link ~/.local/<subdirs> ---
if [ -d "$DOTFILES_DIR/.local" ]; then
  mkdir -p "$HOME/.local"
  link_dir "$DOTFILES_DIR/.local" "$HOME/.local"
fi

echo "✅ Dotfiles linked successfully."

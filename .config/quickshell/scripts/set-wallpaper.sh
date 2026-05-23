#!/usr/bin/env bash
path=$(/usr/sbin/zenity --file-selection --filename="$HOME/wallpapers/") || exit 0
[[ -z "$path" ]] && exit 0

matugen image "$path" -t scheme-content --prefer lightness --source-color-index 0 --continue-on-error

hyprctl hyprpaper wallpaper ",$path,"
cat > ~/.config/hypr/hyprpaper.conf << EOF
wallpaper {
    monitor =
    path = $path
}
EOF

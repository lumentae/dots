hyprctl hyprpaper wallpaper ",$1,"
cat > ~/.config/hypr/hyprpaper.conf << EOF
wallpaper {
    path = $1
}
EOF
function fish_greeting
    fastfetch
    bash ~/dots/scripts/greet.sh $GEO_LATITUDE $GEO_LONGITUDE
end

function updatePearDesktop
    git clone https://github.com/pear-devs/pear-desktop
    cd pear-desktop
    git checkout 90a31daf24f53528e1f3086bfdd5544999a34f65
    pnpm install --frozen-lockfile
    pnpm dist:linux
    cp pack/YouTube\ Music-3.11.0.AppImage ~/.local/bin/pear-desktop/YouTubeMusic.AppImage
    rm -rf pear-desktop
end
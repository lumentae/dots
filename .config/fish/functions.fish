function fish_greeting
    fastfetch
    bash ~/dots/scripts/greet.sh $GEO_LATITUDE $GEO_LONGITUDE
end

function updatePearDesktop
    git clone https://github.com/pear-devs/pear-desktop
    cd pear-desktop
    # git checkout 90a31daf24f53528e1f3086bfdd5544999a34f65
    pnpm install --frozen-lockfile
    pnpm dist:linux
    cp pack/YouTube\ Music-3.11.0.AppImage ~/.local/bin/pear-desktop/YouTubeMusic.AppImage
    rm -rf pear-desktop
end

function updateNvidiaDrivers
    nvidia-smi | string match -r "KMD Version: (?<major>\d+)\.(?<minor>\d+)\.(?<revision>\d+)" >nul
    echo "Updating to $major.$minor.$revision"
    set hash (nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/$major.$minor.$revision/NVIDIA-Linux-x86_64-$major.$minor.$revision.run 2>&1 | grep -o 'sha256-[A-Za-z0-9+/=]*')
    echo "New hash: $hash"
    sed -i -E \
        's/version = "[0-9]+\.[0-9]+\.[0-9]+";/version = "'"$major.$minor.$revision"'";/;s|sha256 = ".+";|sha256 = "'"$hash"'";|' \
        ~/dots/nix/home.nix
    nr
end

function fixHyprland
    hyprctl --instance 0 eval "hl.config({ misc = {allow_session_lock_restore = true}})"
    hyprctl --instance 0 eval "hl.dispatch(hl.dsp.exec_cmd('hyprlock'))"
    hyprctl --instance 0 dispatch 'hl.dsp.dpms({action="enable"})' 
end

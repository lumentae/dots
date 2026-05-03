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

function updateNvidiaDrivers
    # TODO: Skip update if version is up to date
    nvidia-smi | string match -r "Driver Version: (?<major>\d+)\.(?<minor>\d+)\.(?<revision>\d+)" > nul
    echo "Updating to $major.$minor.$revision"
    set hash (nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/$major.$minor.$revision/NVIDIA-Linux-x86_64-$major.$minor.$revision.run 2>&1 | grep -o 'sha256-[A-Za-z0-9+/=]*')
    sed -i -E "s/version = \"[0-9]+\.[0-9]+\.[0-9]+\";/version = \"$major.$minor.$revision\";/;s/sha256 = \".+\";/sha256 = \"$hash\";/" ~/dots/nix/home.nix
    echo "New hash: $hash"
    nr
end
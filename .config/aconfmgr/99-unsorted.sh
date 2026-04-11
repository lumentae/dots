# Sat Apr 11 09:47:03 PM CEST 2026 - Unknown packages
AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel # Basic tools to build Arch Linux packages
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
AddPackage brightnessctl # Lightweight brightness control tool
AddPackage btrfs-progs # Btrfs filesystem utilities
AddPackage cups # OpenPrinting CUPS - daemon package
AddPackage cups-pk-helper # A helper that makes system-config-printer use PolicyKit
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
AddPackage fish # Smart and user friendly shell intended mostly for interactive use
AddPackage flatpak # Linux application sandboxing and distribution framework (formerly xdg-app)
AddPackage fuse2 # Interface for userspace programs to export a filesystem to the Linux kernel
AddPackage gst-plugin-pipewire # Multimedia graph framework - pipewire plugin
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprlock # hyprland’s GPU-accelerated screen locking utility
AddPackage libpulse # A featureful, general-purpose sound server (client library)
AddPackage linux-firmware # Firmware files for Linux - Default set
AddPackage linux-zen # The Linux ZEN kernel and modules
AddPackage linux-zen-headers # Headers and scripts for building modules for the Linux ZEN kernel
AddPackage ly # TUI display manager
AddPackage nano # Pico editor clone with enhancements
AddPackage networkmanager # Network connection manager and user applications
AddPackage nix # A purely functional package manager
AddPackage noto-fonts-cjk # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto Color Emoji font
AddPackage noto-fonts-extra # Google Noto TTF fonts - additional variants
AddPackage nvidia-open-dkms # NVIDIA open kernel modules - module sources
AddPackage pavucontrol # PulseAudio Volume Control
AddPackage pipewire # Low-latency audio/video router and processor
AddPackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-jack # Low-latency audio/video router and processor - JACK replacement
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage steam # Valve's digital software delivery system
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage system-config-printer # A CUPS printer configuration tool and status applet
AddPackage ttf-jetbrains-mono-nerd # Patched font JetBrains Mono from nerd fonts library
AddPackage wireplumber # Session / policy manager implementation for PipeWire
AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
AddPackage zram-generator # Systemd unit generator for zram devices

# Sat Apr 11 09:47:04 PM CEST 2026 - Unknown foreign packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign pear-desktop # Extension for music player
AddPackage --foreign vicinae-bin # Raycast like FOSS app on Linux
AddPackage --foreign yay-bin # Yet another yogurt. Pacman wrapper and AUR helper written in go. Pre-compiled.
AddPackage --foreign yay-bin-debug # Detached debugging symbols for yay-bin

# Sat Apr 11 09:47:04 PM CEST 2026 - New / changed files
CopyFile /etc/fstab
CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Berlin
CopyFile /etc/nix/nix.conf
CreateLink /etc/systemd/system/autovt@.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/cups.path /usr/lib/systemd/system/cups.path
CreateLink /etc/systemd/system/multi-user.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/multi-user.target.wants/ly@tty1.service /usr/lib/systemd/system/ly@.service
CreateLink /etc/systemd/system/multi-user.target.wants/nix-daemon.service /usr/lib/systemd/system/nix-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/non-nixos-gpu.service /nix/store/si880j7yvs2ps6xwr8kpni9rlnk6yv61-non-nixos-gpu/lib/systemd/system/non-nixos-gpu.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service /usr/lib/systemd/system/NetworkManager-wait-online.service
CreateLink /etc/systemd/system/non-nixos-gpu.service /nix/store/si880j7yvs2ps6xwr8kpni9rlnk6yv61-non-nixos-gpu/lib/systemd/system/non-nixos-gpu.service
CreateLink /etc/systemd/system/printer.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-userdbd.socket /usr/lib/systemd/system/systemd-userdbd.socket
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/user/graphical-session-pre.target.wants/xdg-user-dirs.service /usr/lib/systemd/user/xdg-user-dirs.service
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/sockets.target.wants/gnome-keyring-daemon.socket /usr/lib/systemd/user/gnome-keyring-daemon.socket
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
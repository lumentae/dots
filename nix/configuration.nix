# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.settings = {
    download-buffer-size = 524288000; # 500 MiB
  };

  nixpkgs.overlays = [
    (import ./overlays/idea-2026.1.nix)
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "preempt=full"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia_drm.modeset=1"
  ];

  networking.hostName = "lumentae-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  users.groups.plugdev = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lumentae = {
    isNormalUser = true;
    description = "lumentae";
    extraGroups = [ "networkmanager" "wheel" "dialout" "tty" "input" "plugdev" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services = {
    displayManager.ly.enable = true;
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    cifs-utils
    crosspipe
    curl
    fastfetch
    gcc
    jq
    killall
    neovim
    ntfs3g
    pulseaudio
    starship
    unzip
    wget
    usbutils
  ];

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Programs config:
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.appimage.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    brotli
    unixodbc
    zstd
    glib
    gcc
    libxkbcommon
  ];

  # List services that you want to enable:
  services.blueman.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  services.flatpak.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.udev.packages = with pkgs; [
    arduino
    platformio-core
  ];
  services.udev.extraRules = builtins.readFile "${pkgs.platformio-core}/lib/python3.13/site-packages/platformio/assets/system/99-platformio-udev.rules";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hardware configuration:
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the Nvidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/E54411BEDC8DB6BE";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=1000" "rw" "umask=022" "nofail" ];
  };

  fileSystems."/mnt/server/root" = {
    device = "//192.168.2.2/root";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,_netdev,nofail";
    in [ "${automount_opts},credentials=/etc/smb-secrets" ];
  };

  fileSystems."/mnt/server/lvm" = {
    device = "//192.168.2.2/lvm";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,_netdev,nofail";
    in [ "${automount_opts},credentials=/etc/smb-secrets" ];
  };
}

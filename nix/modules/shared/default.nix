{ config, pkgs, ... }:

{
  nix.settings = {
    download-buffer-size = 524288000;
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

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

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  console.keyMap = "de";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    btop
    curl
    fastfetch
    gcc
    jq
    killall
    neovim
    pulseaudio
    starship
    unzip
    wget
    usbutils
  ];

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.openssh.enable = true;
  services.udev.packages = with pkgs; [
    arduino
  ];

  services.flatpak.enable = true;
  services.blueman.enable = true;

  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}

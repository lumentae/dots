{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  targets.genericLinux = {
    enable = true;
    gpu.nvidia = {
      enable = true;
      version = "595.71.05";
      sha256 = "sha256-NiA7iWC35JyKQva6H1hjzeNKBek9KyS3mK8G3YRva4I=";
    };
  };

  home.username = "lumentae";
  home.homeDirectory = "/home/lumentae";

  home.stateVersion = "25.11";

  imports = [
    inputs.zen-browser.homeModules.twilight
    (import ./overlays/default.nix)
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "lumentae";
        email = "me@lumentae.dev";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bibata-cursors
    btop
    cascadia-code
    cliphist
    code-cursor
    easyeffects
    eza
    fastfetch
    kdePackages.gwenview
    hyprpaper
    hyprpicker
    hyprshot
    iperf
    jellyfin-rpc
    jetbrains.clion
    jetbrains.idea
    jq
    libnotify
    mako
    mangohud
    material-symbols
    moonlight-qt
    neovim
    playerctl
    pnpm
    starship
    unzip
    usbutils
    uv
    vlc
    wayland
    wayland-utils
    wl-clipboard
    zip
  ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 22;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
  };

  home.file = builtins.listToAttrs (
    builtins.map (name: {
      name = ".config/${name}";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dots/.config/${name}";
        force = true;
      };
    }) [
      "aconfmgr"
      "cava"
      "fastfetch"
      "fish"
      "hypr"
      "kitty"
      "mako"
      "matugen"
      "nvim"
      "quickshell"
    ]
  );
}

{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    inputs.zen-browser.homeModules.twilight
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

  home.packages = with pkgs; [
    bibata-cursors
    cliphist
    code-cursor
    easyeffects
    eza
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    jellyfin-rpc
    jetbrains.idea
    kitty
    libnotify
    mako
    playerctl
    pnpm
    quickshell
    vesktop
    vicinae
    wayland
    wayland-utils
    wl-clipboard
  ];

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
      };
    }) [
      "fastfetch"
      "fish"
      "hypr"
      "kitty"
      "nvim"
      "quickshell"
    ]
  );
}

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

  home.packages = [
    pkgs.vicinae
    pkgs.code-cursor
    pkgs.vesktop
    pkgs.easyeffects
    pkgs.jetbrains.idea
    pkgs.pnpm
    pkgs.eza
    pkgs.jellyfin-rpc
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 22;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
  };
}

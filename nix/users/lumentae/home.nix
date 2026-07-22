{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "lumentae";
  home.homeDirectory = "/home/lumentae";

  home.stateVersion = "25.11";

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
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
      xdg-desktop-portal-hyprland
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
    cascadia-code
    cliphist
    eza
    fastfetch
    hyprpicker
    hyprshot
    libnotify
    mako
    neovim
    playerctl
    pnpm
    starship
    unzip
    uv
    wayland
    wayland-utils
    wl-clipboard
    zip
    material-symbols
    quickshell
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

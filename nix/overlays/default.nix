{
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  nixpkgs.overlays = [
    (import ./idea-2026.1.nix)
    (import ./clion-2026.1.nix)
  ];
}
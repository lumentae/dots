{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        lumentae-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hardware-configuration.nix
            ./hosts/lumentae-desktop
          ];
        };

        lumentae-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hardware-configuration.nix
            ./hosts/lumentae-laptop
          ];
        };
      };

      homeConfigurations."lumentae-arch" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./users/lumentae/home.nix ];
      };
    };
}

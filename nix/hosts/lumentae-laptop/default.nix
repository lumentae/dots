{ config, pkgs, inputs, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/shared
    ../../modules/services
    ../../profiles/laptop
    ../../users/lumentae/user.nix
    home-manager.nixosModules.default
    {
      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.lumentae = ../../users/lumentae/home.nix;
      };
    }
  ];
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/shared
    ../../modules/services
    ../../profiles/desktop
    ../../users/lumentae/user.nix
    inputs.home-manager.nixosModules.default
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

{ config, pkgs, ... }:

{
  networking.hostName = "lumentae-laptop";
  networking.networkmanager.enable = true;
}

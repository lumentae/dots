{ config, pkgs, ... }:

{
  networking.hostName = "lumentae-desktop";
  networking.networkmanager.enable = true;
}

{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "preempt=full"
  ];

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  
  services.avahi.enable = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "lock";

  services.upower.enable = true;

  home-manager.users.lumentae.home.packages = with pkgs; [ ];
}

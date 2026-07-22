{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "preempt=full"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia_drm.modeset=1"
  ];

  services.displayManager.ly.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    ntfs3g
  ];

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/E54411BEDC8DB6BE";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=1000" "rw" "umask=022" "nofail" ];
  };

  fileSystems."/mnt/server/root" = {
    device = "//192.168.2.2/root";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,_netdev,nofail";
    in [ "${automount_opts},credentials=/etc/smb-secrets" ];
  };

  fileSystems."/mnt/server/lvm" = {
    device = "//192.168.2.2/lvm";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,_netdev,nofail";
    in [ "${automount_opts},credentials=/etc/smb-secrets" ];
  };

  home-manager.users.lumentae = {
    home.packages = with pkgs; [
      code-cursor
      easyeffects
      kdePackages.gwenview
      iperf
      jellyfin-rpc
      jetbrains.clion
      jetbrains.idea
      mangohud
      quickshell
      vlc
    ];
  };
}

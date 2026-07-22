{ pkgs, ... }:

{
  users.users.lumentae = {
    isNormalUser = true;
    description = "lumentae";
    extraGroups = [ "networkmanager" "wheel" "dialout" "tty" "input" "plugdev" ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };

  users.groups.plugdev = { };
}

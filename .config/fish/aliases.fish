alias ls 'eza --icons -lag'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias nr 'sudo nixos-rebuild switch --flake /home/lumentae/dots/nix#lumentae-nixos --impure'
alias rw "bootctl set-oneshot windows && reboot"
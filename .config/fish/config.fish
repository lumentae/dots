function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias ls 'eza --icons -lag'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias r 'sudo nixos-rebuild switch --flake /home/lumentae/dots/nix#lumentae-nixos --impure'
    if test -e /etc/environment.fish
        source /etc/environment.fish
    end
    if not string match -q "*$PNPM_HOME*" $PATH
        set -x PATH $PNPM_HOME $PATH
    end
end

function fish_greeting
    fastfetch
    bash ~/dots/scripts/greet.sh $GEO_LATITUDE $GEO_LONGITUDE
end

# terminal-wakatime setup
set -gx PATH "$HOME/.wakatime" $PATH
terminal-wakatime init fish | source

# pnpm
set -gx PNPM_HOME "~/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

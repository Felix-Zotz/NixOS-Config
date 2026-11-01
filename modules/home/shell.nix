{ pkgs, ... }: {
  programs = {
    bash.enable = true;
    fish.enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    ddcutil
    spotify-player
    pulseaudio
    tmux
  ];
  services.playerctld.enable = true;

  programs.home-manager.enable = true;

  home.shellAliases = {
    down = "systemctl poweroff";
    sus = "systemctl suspend";
    nix_update = "nix flake update --flake ~/.config/nixos";
  };
}

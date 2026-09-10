{pkgs, ...}: {
  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    python312
    rustup
    ripgrep
    fd
    bat
    ddcutil
    spotify-player
  ];
  services.playerctld.enable = true;

  programs.home-manager.enable = true;
}

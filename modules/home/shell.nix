{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
  ];

  programs.home-manager.enable = true;
}

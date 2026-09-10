{pkgs, ...}: {
  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    ddcutil
  ];
  services.playerctld.enable = true;

  programs.home-manager.enable = true;
}

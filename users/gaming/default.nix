{...}: {
  users.users.gaming = {
    isNormalUser = true;
    description = "Gaming";
    extraGroups = ["video" "render" "input" "seat"];
  };

  home-manager.users.gaming = {
    imports = [
      ../../modules/home/firefox.nix
      ../../modules/home/gaming.nix
      ../../modules/home/ghostty.nix
      ../../modules/home/git.nix
      ../../modules/home/keepassxc.nix
      ../../modules/home/neovim.nix
      ../../modules/home/shell.nix
      ../../modules/home/sway.nix
      ../../modules/home/yazi.nix
    ];
    home.stateVersion = "26.05";
  };
}

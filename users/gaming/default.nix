{...}: {
  users.users.gaming = {
    isNormalUser = true;
    description = "Gaming";
    extraGroups = ["video" "render" "input" "seat"];
  };

  home-manager.users.gaming = {
    imports = [
      ../../modules/home/shell.nix
      ../../modules/home/git.nix
      ../../modules/home/gaming.nix
      ../../modules/home/sway.nix
      ../../modules/home/neovim.nix
      ../../modules/home/firefox.nix
    ];
    home.stateVersion = "26.05";
  };
}

{...}: {
  users.users.felix = {
    isNormalUser = true;
    description = "Felix";
    extraGroups = ["wheel" "video" "render" "seat"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO7hjdiYFf4xcm9Me9hmNus1GzSOcyj0VNyGEffSDaRo mobile@localhost" # iPad
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLfCCh1G0zd8vXgS8aGPZO0ruW+AtAmAznCy1o8CBqI PC-F" # PC (Won't be necessary soon)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEMgGZKX8GN6UhAg81JOQRXHEP6JnL9oeZgGbBAYq3wt u0_a476@localhost" # Motorola Edge 40
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGm8KzWHMs1Js88AYGgY/QuMUUYBJc6jv7vJtXXePje4 felix@felix-mobile" # Laptop
    ];
  };

  home-manager.users.felix = {
    imports = [
      ../../modules/home/shell.nix
      ../../modules/home/git.nix
      ../../modules/home/sway.nix
      ../../modules/home/neovim.nix
      ../../modules/home/firefox.nix
      ../../modules/home/vscode.nix
    ];
    home.stateVersion = "26.05";
  };
}

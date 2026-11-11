{ ... }: {
  users.users.felix = {
    isNormalUser = true;
    description = "Felix";
    extraGroups = [
      "wheel"
      "video"
      "render"
      "seat"
      "i2c"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO7hjdiYFf4xcm9Me9hmNus1GzSOcyj0VNyGEffSDaRo mobile@localhost" # iPad
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGk8Qe/DTAqd/Cm9YGC6k4W7M5hnY1Fq/jRwbfRzE3T motorola-edge-40" # Motorola Edge 40
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGm8KzWHMs1Js88AYGgY/QuMUUYBJc6jv7vJtXXePje4 felix@felix-mobile" # Laptop
    ];
  };

  home-manager.users.felix = {
    imports = [
      ../../modules/home/firefox.nix
      ../../modules/home/ghostty.nix
      ../../modules/home/git.nix
      ../../modules/home/gtk.nix
      ../../modules/home/helix.nix
      ../../modules/home/keepassxc.nix
      ../../modules/home/media_viewer.nix
      ../../modules/home/shell.nix
      ../../modules/home/sway.nix
      ../../modules/home/toolchains.nix
      ../../modules/home/vscode.nix
      ../../modules/home/yazi.nix
    ];
    home.stateVersion = "26.05";
  };
}

{pkgs, ...}: {
  imports = [
    ./hardware.nix

    ../../modules/nixos/audio.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/gpu.nix
    ../../modules/nixos/headless-boot.nix
    ../../modules/nixos/sway.nix

    ../../users/felix
  ];

  networking.hostName = "Laptop";

  # Bootloader + kernel choice live here, not in core.nix - a future
  # second host (different disk layout, different hardware) shouldn't
  # inherit this by accident.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "26.05";

  home-manager.users.felix.home.shellAliases = {
    build = "sudo nixos-rebuild build --flake ~/.config/nixos#Laptop";
    rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#Laptop";
    batt = "cat /sys/class/power_supply/BAT*/capacity";
  };
}

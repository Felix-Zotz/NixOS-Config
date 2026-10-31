{ pkgs, ... }: {
  imports = [
    ./hardware.nix

    ../../modules/nixos/audio.nix
    ../../modules/nixos/battery.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/gpu.nix
    ../../modules/nixos/headless-boot.nix
    ../../modules/nixos/sway.nix
    ../../modules/nixos/syncthing.nix

    ../../users/felix
  ];

  networking.hostName = "Laptop";
  networking.networkmanager.enable = true;

  # Bootloader + kernel choice live here, not in core.nix - a future
  # second host (different disk layout, different hardware) shouldn't
  # inherit this by accident.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "26.05";

  home-manager.users.felix.home.shellAliases = {
    nix_build = "sudo nixos-rebuild build --flake ~/.config/nixos#Laptop";
    nix_switch = "sudo nixos-rebuild switch --flake ~/.config/nixos#Laptop";
    nix_try-run = "sudo nixos-rebuild dry-run --flake ~/.config/nixos#Laptop";
    nix_test = "sudo nixos-rebuild test --flake ~/.config/nixos#Laptop";
    batt = "cat /sys/class/power_supply/BAT*/capacity";
  };

  services.syncthing.settings = {
    gui.user = "laptop";
    devices = {
      "workstation-server" = {
        id = "DL4EFRE-JRCNOUT-TUOW4R6-QUWUXN2-KN77LVK-EOLTYT3-HZQYRXV-K6GPAQT";
      };
    };
    folders = {
      "passwords" = {
        devices = [
          "workstation-server"
          "smartphone"
          "iPad"
        ];
      };
      "markdown" = {
        devices = [
          "workstation-server"
          "smartphone"
          "iPad"
        ];
      };
    };
  };
}

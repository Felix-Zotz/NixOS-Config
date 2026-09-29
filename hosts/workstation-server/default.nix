{pkgs, ...}: {
  imports = [
    ./hardware.nix

    ../../modules/nixos/audio.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/gpu.nix
    ../../modules/nixos/server-services.nix
    ../../modules/nixos/headless-boot.nix
    ../../modules/nixos/sway.nix

    ../../users/felix
    ../../users/gaming
  ];

  networking.hostName = "Workstation-Server";

  # Bootloader + kernel choice live here, not in core.nix - a future
  # second host (different disk layout, different hardware) shouldn't
  # inherit this by accident.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Static IP setup is inherently host-specific (interface name,
  # actual address) - stays here, never in a shared module.
  networking.useNetworkd = true;
  services.resolved.enable = true;
  networking.networkmanager.enable = false;
  networking.interfaces.enp37s0.ipv4.addresses = [
    {
      address = "192.168.178.176";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = {
    address = "192.168.178.1";
    interface = "enp37s0";
  };
  networking.nameservers = ["1.1.1.1" "192.168.178.1"];

  fileSystems."/mnt/hdd1" = {
    device = "/dev/disk/by-uuid/1d0e5eac-e7f0-474f-8403-137b3b1fbecc";
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd2" = {
    device = "/dev/disk/by-uuid/56bfe721-c392-4d7a-8cb9-fb5f6e8fd400";
    fsType = "ext4";
  };

  fileSystems."/mnt/sata-ssd" = {
    device = "/dev/disk/by-uuid/025f42c8-e879-4c3f-ac12-b294b651e1b5";
    fsType = "ext4";
  };

  system.stateVersion = "26.05";

  home-manager.users.felix.home.shellAliases = {
    build = "sudo nixos-rebuild build --flake ~/.config/nixos#Workstation-Server";
    switch = "sudo nixos-rebuild switch --flake ~/.config/nixos#Workstation-Server";
  };
}

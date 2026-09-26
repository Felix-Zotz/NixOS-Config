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

  system.stateVersion = "26.05";
}

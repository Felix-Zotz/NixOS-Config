{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      ocl-icd
      rocmPackages.clr.icd # OpenCL
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      ocl-icd
      stdenv.cc.cc.lib
      libGL
    ];
  };

  # Power management for the discrete AMD card - PCI device IDs are
  # specific to this GPU, keep an eye on this if the card ever changes.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x743f", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card*", ATTR{device/power_dpm_force_performance_level}="auto"
  '';
}

{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      ocl-icd
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
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
}

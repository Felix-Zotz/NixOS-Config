{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    graalvmPackages.graalvm-oracle_25
    python312
  ];
}

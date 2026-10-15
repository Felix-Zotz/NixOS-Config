{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup

    gcc
    clang

    graalvmPackages.graalvm-oracle_25

    uv
  ];
}

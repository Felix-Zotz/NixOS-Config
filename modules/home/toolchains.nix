{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup

    clang

    graalvmPackages.graalvm-oracle_25

    uv
  ];
}

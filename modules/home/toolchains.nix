{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup

    clang
    (lib.setPrio 10 gcc)

    graalvmPackages.graalvm-oracle_25

    uv
  ];
}

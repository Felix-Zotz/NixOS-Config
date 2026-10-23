{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup

    clang

    graalvmPackages.graalvm-oracle_25

    pyright
    ruff
    uv

    rust-analyzer
    cargo
    rustfmt
    clippy

    nixd
    nixfmt
  ];
}

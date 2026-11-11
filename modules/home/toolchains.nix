{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Rust
    rustup

    # C & C++
    clang
    clang-tools

    # Python
    python3
    ruff
    ty
    uv
  ];
}

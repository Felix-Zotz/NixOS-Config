{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Rust
    rustup

    # C & C++
    clang
    clang-tools

    # Java & Kotlin
    graalvmPackages.graalvm-oracle_25

    # Python
    pyright
    ruff
    uv
    ty

    # Nix
    nixd
    nixfmt

    # JSON & JSONC
    biome
    vscode-langservers-extracted

    # Markdown
    rumdl

    # TOML
    tombi

    # YAML
    yaml-language-server
    yamlfmt
  ];
}

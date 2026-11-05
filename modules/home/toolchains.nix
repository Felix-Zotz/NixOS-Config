{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Rust
    rustup

    # C & C++
    clang
    clang-tools

    # Python
    python3
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

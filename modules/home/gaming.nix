{pkgs, ...}: {
  # Minimal starting point - fill in what you actually run.
  home.packages = with pkgs; [
    steam
    prismlauncher
  ];
}

{ ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "ctrl+enter=unbind"
        "f11=toggle_fullscreen"
      ];
    };
  };
}

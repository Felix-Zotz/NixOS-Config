{ pkgs, ... }:

{
  home.packages = [ pkgs.fuzzel pkgs.waybar ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "${pkgs.fuzzel}/bin/fuzzel_path | ${pkgs.fuzzel}/bin/fuzzel | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.waybar}/bin/waybar";
        }
      ];
    };
  };
}

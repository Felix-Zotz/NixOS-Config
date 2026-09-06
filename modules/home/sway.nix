{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    fuzzel
    grim
    slurp
    wl-clipboard
  ];

  programs.waybar = {
    enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "${pkgs.fuzzel}/bin/fuzzel_path | ${pkgs.fuzzel}/bin/fuzzel | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      output."DP-1".scale = "1.25";

      input."type:keyboard" = {
        xkb_layout = "eu";
        repeat_delay = "150";
        repeat_rate = "50";
      };

      bars = [];
      startup = [
        {command = "${pkgs.waybar}/bin/waybar";}
      ];

      keybindings = let
        inherit (config.wayland.windowManager.sway.config) modifier;
      in
        lib.mkOptionDefault {
          "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
          "Shift+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" ~/Bilder/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png";
          "${modifier}+Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        };
    };
  };
}

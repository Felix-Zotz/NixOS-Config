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

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "${pkgs.fuzzel}/bin/fuzzel_path | ${pkgs.fuzzel}/bin/fuzzel | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      output."DP-1".scale = "1.25";

      input = {
        "type:keyboard" = {
          xkb_layout = "eu";
          repeat_delay = "150";
          repeat_rate = "50";
        };
        "type:pointer" = {
          accel_profile = "flat";
          natural_scroll = "enabled";
        };
      };
      bars = [];

      keybindings = let
        inherit (config.wayland.windowManager.sway.config) modifier;
      in
        lib.mkOptionDefault {
          "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
          "Shift+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" ~/Bilder/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png";
          "${modifier}+Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";

          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioStop" = "exec playerctl stop";

          "XF86MonBrightnessDown" = " exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = " exec brightnessctl set 5%+";
        };
    };
  };
}

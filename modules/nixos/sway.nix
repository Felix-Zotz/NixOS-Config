{
  pkgs,
  lib,
  ...
}: {
  programs.sway = {
    enable = true;
    extraPackages = lib.mkForce [];
  };

  services.seatd.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
}

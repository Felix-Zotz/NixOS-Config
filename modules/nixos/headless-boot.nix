{lib, ...}: {
  services.xserver.enable = lib.mkForce false;
  systemd.defaultUnit = lib.mkForce "multi-user.target";
}

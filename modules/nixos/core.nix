{
  pkgs,
  lib,
  ...
}: {
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "eurkey";
  };
  console.useXkbConfig = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [git neovim];
    variables.EDITOR = "nvim";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [22];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  services.journald.extraConfig = "SystemMaxUse=500M";

  programs.dconf.enable = true;
}

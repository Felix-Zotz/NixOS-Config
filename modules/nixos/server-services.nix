{pkgs, ...}: {
  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0";
    openFirewall = true;
    environment = {
      OPENAI_API_BASE_URLS = "https://openrouter.ai/api/v1";
      WEBUI_AUTH = "true";
      ANONYMIZED_TELEMETRY = "false";
    };
  };

  services.opencloud = {
    enable = true;
    address = "0.0.0.0";
    port = 9200;
    url = "http://192.168.178.176:9200";
    environmentFile = "/etc/opencloud/secrets.env"; # JWT_SECRET, ADMIN_PASSWORD etc.
  };

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/sata-ssd";
    accelerationDevices = null;
  };
  users.users.immich.extraGroups = ["video" "render"];

  networking.firewall.allowedTCPPorts = [9200];

  # Automatic shutdown for the night
  systemd.timers.scheduled-shutdown = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "22:45";
      Unit = "poweroff.target";
      Persistent = false;
    };
  };

  systemd.services.hd-idle = {
    description = "hd-idle - spin down idle HDDs";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.hd-idle}/bin/hd-idle -i 0 \
          -a /dev/disk/by-id/ata-ST1000DM003-1SB102_ZN15QTXL -i 600 \
          -a /dev/disk/by-id/ata-TOSHIBA_HDWD110_218TKVZFS -i 600
      '';
      Restart = "on-failure";
      RestartSec = "10s";
      ProtectSystem = "full";
      ProtectHome = true;
    };
  };

  powerManagement.cpuFreqGovernor = "powersave";
}

{pkgs, ...}: {
  # 25565 = Minecraft, 8080 = Open WebUI, 9200 = OpenCloud
  networking.firewall.allowedTCPPorts = [25565 8080 9200];
  # 24454 = Minecraft voice chat
  networking.firewall.allowedUDPPorts = [24454];

  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0";
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
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    accelerationDevices = null;
  };
  users.users.immich.extraGroups = ["video" "render"];

  # Automatic shutdown for the night
  systemd.timers.scheduled-shutdown = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "23:15";
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

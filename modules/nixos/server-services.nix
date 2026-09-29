{pkgs, ...}: {
  networking.firewall = {
    allowedTCPPorts = [25565]; # Minecraft
    allowedUDPPorts = [24454]; # Minecraft Voice-Chat
  };

  services.cloudflared = {
    enable = true;
    tunnels."16def8b5-0164-43e3-ba30-b5c049fd7dbc" = {
      credentialsFile = "/var/lib/cloudflared/creds.json";
      ingress = {
        "open-webui.irrwichte.de" = "http://127.0.0.1:8080";
        "opencloud.irrwichte.de" = "http://127.0.0.1:9200";
        "immich.irrwichte.de" = "http://127.0.0.1:2283";
        # TODO:SSH (?)
      };
      default = "http_status:404";
    };
  };

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
    url = "https://opencloud.irrwichte.de";
    environmentFile = "/etc/opencloud/secrets.env"; # JWT_SECRET, ADMIN_PASSWORD etc.
  };

  services.immich = {
    enable = true;
    port = 2283;
    mediaLocation = "/mnt/sata-ssd";
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

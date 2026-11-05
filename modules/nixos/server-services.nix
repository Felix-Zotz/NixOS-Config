{ pkgs, ... }: {
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
    package = pkgs.opencloud;
    address = "0.0.0.0";
    port = 9200;
    url = "http://192.168.178.176:9200";
    stateDir = "/var/lib/opencloud";
    environment = {
      STORAGE_USERS_POSIX_ROOT = "/mnt/hdd2";
    };
    environmentFile = "/etc/opencloud/secrets.env";
  };

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/sata-ssd";
    accelerationDevices = null;

    environment = {
      TZ = "Europe/Berlin";
    };

    settings = {
      machineLearning.duplicateDetection = {
        maxDistance = 0.03;
      };
      ffmpeg = {
        targetVideoCodec = "hevc";
        targetAudioCodec = "opus";
        acceptedVideoCodecs = [
          "hevc"
          "vp9"
          "av1"
        ];
        acceptedAudioCodecs = [
          "aac"
          "opus"
        ];
        temporalAQ = true;
        targetResolution = "1080";
        realtime = {
          enabled = true;
          resolutions = [
            720
            1080
            1440
          ];
        };
      };
      nightlyTasks = {
        startTime = "06:05";
      };
      image = {
        thumbnail = {
          quality = 70;
          format = "webp";
        };
        preview = {
          quality = 70;
          format = "webp";
        };
        fullsize = {
          enabled = true;
          format = "webp";
        };
      };
      backup.database = {
        enabled = true;
        cronExpression = "30 22 * * *";
      };
    };
  };

  users = {
    users.immich = {
      extraGroups = [
        "video"
        "render"
      ];
      uid = 999;
    };
    groups.immich.gid = 998;
  };

  systemd = {
    tmpfiles.rules = [
      "Z /mnt/sata-ssd - immich immich - -"
    ];
    services = {
      opencloud.unitConfig.RequiresMountsFor = "/mnt/hdd2";
      immich-server.unitConfig.RequiresMountsFor = "/mnt/sata-ssd";
    };
  };

  systemd.timers.scheduled-shutdown = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "22:45";
      Unit = "poweroff.target";
      Persistent = false;
    };
  };

  systemd.services.hd-idle = {
    description = "hd-idle - spin down idle HDDs";
    wantedBy = [ "multi-user.target" ];
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

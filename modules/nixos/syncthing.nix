{...}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiPasswordFile = "/etc/syncthing-gui-password";

    devices = {
      "smartphone" = { id = "XZNB2O2-3Y7SP36-ZPVWYRW-ZWDTATB-S7SOK6Z-6ZCDQF6-PZKJWX6-TRGJHAE"; };
      "iPad" = { id = "2Y7GOFV-BK6TBRO-DBZR7AE-LD6HUUC-KVPEPL2-KEPPL73-B5EQCTH-EXEGRQP"; };
    };
    folders = {
      "passwords" = {
        path = "/home/felix/passwords";
      };
      "markdown" = {
        path = "/home/felix/markdown";
      };
    };

  };
}

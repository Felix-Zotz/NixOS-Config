{ ... }: {
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser.Enabled = true;
      General = {
        LastDatabases = "/home/felix/passwords/Passwords.kdbx";
        LastActiveDatabase = "/home/felix/passwords/Passwords.kdbx";
        OpenPreviousDatabasesOnStartup = true;
      };
    };
  };
}

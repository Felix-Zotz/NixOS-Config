{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Felix Zotz";
    userEmail = "felix.zotz@gmail.com";

    extraConfig = {
      pull.rebase = true;
    };
  };
}

{ ... }: {
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Felix Zotz";
          email = "felix.zotz@gmail.com";
        };
        gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
        pull.rebase = true;
      };
      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519_signing.pub";
        signByDefault = true;
      };
    };
    lazygit.enable = true;

    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };

  xdg.configFile."git/allowed_signers".text =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlZEw2xxvBhtHOeBrfozPmKAu382eKy8dm7jlKuD4e3 felix.zotz@gmail.com signing";
  services.ssh-agent.enable = true;
}

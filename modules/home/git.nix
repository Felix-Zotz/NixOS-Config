{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Felix Zotz";
        email = "felix.zotz@gmail.com";
      };
      pull.rebase = true;
    };
  };
}

{
  flake.modules.homeManager.base = hmArgs: {
    programs.rbw = {
      enable = true;
      settings = {
        email = "mightyiampresence@gmail.com";
        pinentry = hmArgs.config.pinentry;
      };
    };
  };
}

{config, ...}: {
  home.base = hmArgs: {
    programs.rbw = {
      enable = true;
      settings = {
        inherit (config.users.mightyiam) email;
        pinentry = hmArgs.config.pinentry;
      };
    };
  };
}

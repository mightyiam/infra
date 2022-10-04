instance: {config, ...}: {
  programs.git = {
    enable = true;
    userName = config.accounts.email.accounts.default.realName;
    userEmail = config.accounts.email.accounts.default.address;
    delta.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
  };
}

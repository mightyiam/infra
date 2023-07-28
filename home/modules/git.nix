instance: {config, ...}: {
  programs.git = {
    enable = true;
    userName = config.accounts.email.accounts.default.realName;
    userEmail = config.accounts.email.accounts.default.address;
    difftastic.enable = true;
    difftastic.background = "dark";
    #difftastic.display = "inline";
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      push.default = "current";
      safe.bareRepository = "explicit";
      rebase.instructionFormat = "%d %s";
    };
  };
}

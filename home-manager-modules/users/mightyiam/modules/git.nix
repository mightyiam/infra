{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = config.accounts.email.accounts.default.realName;
    userEmail = config.accounts.email.accounts.default.address;
    difftastic.enable = true;
    difftastic.background = "dark";
    #difftastic.display = "inline";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push.default = "current";
      safe.bareRepository = "explicit";
      rebase.instructionFormat = "%d %s";
      merge.conflictstyle = "diff3";
      commit.verbose = true;
    };
  };
}

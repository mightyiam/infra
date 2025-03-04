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
      merge.conflictstyle = "zdiff3";
      commit.verbose = true;
      rerere.enabled = true;
      diff.algorithm = "histogram";
      branch.sort = "-committerdate";
      tag.sort = "taggerdate";
    };
  };

  home.packages = with pkgs; [
    # https://github.com/quodlibetor/git-instafix/issues/39
    # git-instafix
    git-trim
  ];
}

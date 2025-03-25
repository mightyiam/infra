{ config, ... }:
{
  flake.modules.homeManager.base.programs.git = {
    userName = config.flake.meta.owner.name;
    userEmail = config.flake.meta.owner.email;
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      commit.verbose = true;
      branch.sort = "-committerdate";
      tag.sort = "taggerdate";
    };
  };
}

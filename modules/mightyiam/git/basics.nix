{config, ...}: {
  home.base = {
    programs.git = {
      enable = true;
      settings = {
        user = {inherit (config.users.mightyiam) name email;};
        init.defaultBranch = "master";
        push.default = "current";
        commit.verbose = true;
        branch.sort = "-committerdate";
        tag.sort = "taggerdate";
      };
      signing.format = null;
    };
  };
}

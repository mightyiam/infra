{
  flake.modules.homeManager.base = {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        config.global.warn_timeout = 0;
      };
      git.ignores = [
        ".envrc"
        ".direnv"
      ];
    };
  };
}

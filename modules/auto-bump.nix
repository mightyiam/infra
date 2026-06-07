{config, ...}: {
  nixos.modules.bow = {
    system.autoUpgrade = {
      enable = true;

      # Seems like this ends up being true by default, which is results in an error
      upgrade = false;

      flake = config.repository.git.flakeUri;
      operation = "boot";
    };
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep 5";
      };
    };
  };
}

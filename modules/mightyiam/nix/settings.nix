{config, ...}: {
  home.base = {
    nix = {
      inherit (config.nix) settings;
    };
  };
}

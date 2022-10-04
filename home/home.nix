with builtins;
  instance: {
    config,
    pkgs,
    options,
    lib,
    ...
  }: let
    username = "mightyiam";
    getName = lib.getName;
    packages = (import ./packages.nix) pkgs;
    modules = import ./modules;
    activeModules = concatMap (feature: getAttr feature modules) instance.features;
  in {
    imports = map (module: import module instance) activeModules;
    home.packages = concatMap (feature: getAttr feature packages) instance.features;

    programs.home-manager = {
      enable = true;
      path =
        if instance ? homeManagerPath
        then instance.homeManagerPath
        else null;
    };

    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "21.05";
      sessionVariables.TZ = "\$(<~/.config/timezone)";
      sessionVariables.CACHIX_AUTH_TOKEN = instance.secrets.CACHIX_AUTH_TOKEN;
    };
  }

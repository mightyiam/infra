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

    programs.home-manager.enable = true;
    programs.home-manager.path =
      if instance ? homeManagerPath
      then instance.homeManagerPath
      else null;

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "21.05";
    home.sessionVariables.TZ = "\$(<~/.config/timezone)";
    home.sessionVariables.CACHIX_AUTH_TOKEN = instance.secrets.CACHIX_AUTH_TOKEN;
  }

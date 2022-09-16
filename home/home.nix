with builtins;
  {
    config,
    pkgs,
    options,
    lib,
    ...
  }: let
    username = "mightyiam";
    instance = import ./instance.nix;
    getName = lib.getName;
    packages = (import ./packages.nix) pkgs;
    modules = import ./modules;
    secrets = import ./secrets.nix;
  in {
    imports = concatMap (feature: getAttr feature modules) instance.features;
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
      sessionVariables.CACHIX_AUTH_TOKEN = secrets.CACHIX_AUTH_TOKEN;
    };
  }

{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (builtins)
    readDir
    ;

  inherit
    (lib)
    attrNames
    concatMap
    getAttr
    mkIf
    mkOption
    types
    ;

  username = "mightyiam";
  getName = lib.getName;
  userAndHome.config = mkIf (!config.isNixOnDroid) {
    home.username = username;
    home.homeDirectory = "/home/${username}";
  };
  packages = (import ./packages.nix) pkgs;
  modules = let
    dir = "${../.}/home/modules";
    relativePaths = attrNames (readDir dir);
  in
    map (path: "${dir}/${path}") relativePaths;
  always = {
    imports = modules;

    config.home.packages = concatMap (feature: getAttr feature packages) ["gui" "tui"];

    config.programs.home-manager.enable = true;

    config.home.stateVersion = "21.05";
    config.home.sessionVariables.TZ = "\$(<~/.config/timezone)";
  };
in {
  options.gui.enable = mkOption {
    type = types.bool;
    default = true;
  };

  options.location.latitude = mkOption {
    type = types.numbers.between (-90) 90;
  };

  options.location.longitude = mkOption {
    type = types.numbers.between (-180) 180;
  };

  options.isNixOnDroid = mkOption {
    type = types.bool;
    default = false;
  };

  imports = [always userAndHome];
}

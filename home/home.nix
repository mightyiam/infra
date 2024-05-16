{
  config,
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
    mkIf
    mkOption
    types
    ;

  username = "mightyiam";
  userAndHome.config = mkIf (!config.isNixOnDroid) {
    home.username = username;
    home.homeDirectory = "/home/${username}";
  };
  modules = let
    dir = "${../.}/home/modules";
    relativePaths = attrNames (readDir dir);
  in
    map (path: "${dir}/${path}") relativePaths;
  always = {
    imports = modules;

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

  options.style.windowOpacity = mkOption {
    type = types.numbers.between 0 1.0;
    default = 1.0;
  };

  imports = [always userAndHome];
}

with builtins;
  {
    config,
    pkgs,
    options,
    lib,
    ...
  }: let
    inherit
      (lib)
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
    activeModules = let
      featureToModulePaths = feature: let
        dir = toString ./modules + "/" + feature;
        relativePaths = attrNames (readDir dir);
      in
        map (path: "${dir}/${path}") relativePaths;
    in
      concatMap featureToModulePaths ["gui" "tui"];
    always = {
      imports = activeModules;

      config.home.packages = concatMap (feature: getAttr feature packages) ["gui" "tui"];

      config.programs.home-manager.enable = true;

      config.home.stateVersion = "21.05";
      config.home.sessionVariables.TZ = "\$(<~/.config/timezone)";
    };
  in {
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

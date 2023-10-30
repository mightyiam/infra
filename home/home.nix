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
    userAndHome =
      if (instance ? "nix-on-droid")
      then {}
      else {
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
      concatMap featureToModulePaths instance.features;
    always = {
      imports = map (module: import module instance) activeModules;
      home.packages = concatMap (feature: getAttr feature packages) instance.features;

      programs.home-manager.enable = true;
      programs.home-manager.path =
        if instance ? homeManagerPath
        then instance.homeManagerPath
        else null;

      home.stateVersion = "21.05";
      home.sessionVariables.TZ = "\$(<~/.config/timezone)";
      home.sessionVariables.CACHIX_AUTH_TOKEN = instance.secrets.CACHIX_AUTH_TOKEN;
    };
  in
    lib.attrsets.recursiveUpdate always userAndHome

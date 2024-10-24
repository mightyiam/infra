{ self, config, ... }:
{
  home-manager = {
    extraSpecialArgs = {
      inherit self;
    };
    useGlobalPkgs = true;
    config.home = {
      inherit (config.system) stateVersion;
    };
    sharedModules = [
      (self + "/home-manager-modules/users/mightyiam")
      { gui.enable = false; }
    ];
  };
}
{
  config,
  ...
}:
{
  flake.modules.nixOnDroid.base = args: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        hasGlobalPkgs = true;
        hasDifferentUsername = true;
      };
      config = {
        home.stateVersion = args.config.system.stateVersion;
        imports = [ config.flake.modules.homeManager.base ];
      };
    };
  };
}

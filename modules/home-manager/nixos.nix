{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos.desktop = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      extraSpecialArgs.hasGlobalPkgs = true;
      useUserPackages = true;

      users.${config.flake.meta.owner.username}.imports = [
        (
          { osConfig, ... }:
          {
            home.stateVersion = osConfig.system.stateVersion;
          }
        )
        config.flake.modules.homeManager.base
        config.flake.modules.homeManager.gui
      ];
    };
  };
}

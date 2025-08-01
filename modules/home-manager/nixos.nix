{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos = {
    base = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs.hasGlobalPkgs = true;
        # https://github.com/nix-community/home-manager/issues/6770
        #useUserPackages = true;

        users.${config.flake.meta.owner.username}.imports = [
          (
            { osConfig, ... }:
            {
              home.stateVersion = osConfig.system.stateVersion;
            }
          )
          config.flake.modules.homeManager.base
        ];
      };
    };
    pc = {
      home-manager.users.${config.flake.meta.owner.username}.imports = [
        config.flake.modules.homeManager.gui
      ];
    };
  };
}

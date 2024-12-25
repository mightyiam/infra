{ self, lib, ... }:
{
  imports = [ self.inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    users.mightyiam.imports = [
      (
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
        }
      )
    ] ++ lib.attrValues self.modules.homeManager;
    extraSpecialArgs = {
      inherit self;
    };
  };
}

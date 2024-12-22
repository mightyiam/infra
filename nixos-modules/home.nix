{ self, ... }:
{
  imports = [ self.inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    users.mightyiam.imports = [
      self.homeManagerModules.common
      ../home-manager-modules
      (
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
        }
      )
    ];
    extraSpecialArgs = {
      inherit self;
    };
  };
}

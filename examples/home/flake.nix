{
  inputs.nixconfigs.url = "github:mightyiam/nixconfigs";
  outputs = {nixconfigs, ...}: {
    homeManagerConfigurations.mightyiam = nixconfigs.inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = nixconfigs.inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        nixconfigs.homeManagerModules.mightyiam
        {
          home.stateVersion = "24.11";
          location.latitude = 18.746;
          location.longitude = 99.075;
        }
      ];
    };
  };
}

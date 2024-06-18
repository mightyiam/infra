{
  inputs.nixconfigs.url = "github:mightyiam/nixconfigs";
  outputs = {nixconfigs, ...}: {
    nixosConfigurations.mightyiam-desktop = nixconfigs.inputs.nixpkgs.lib.nixosSystem {
      modules = [
        nixconfigs.nixosModules.mightyiam-desktop
        {
          home-manager.users.mightyiam.location.latitude = 18.746;
          home-manager.users.mightyiam.location.longitude = 99.075;
        }
      ];
    };
  };
}

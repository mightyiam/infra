{self, ...}: {
  imports = [self.inputs.home-manager.nixosModules.home-manager];
  home-manager.useGlobalPkgs = true;
  home-manager.users.mightyiam.imports = [
    self.homeManagerModules.mightyiam
    ({osConfig, ...}: {home.stateVersion = osConfig.system.stateVersion;})
  ];
}

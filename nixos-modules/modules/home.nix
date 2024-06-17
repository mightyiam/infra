{config, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.users.mightyiam.imports = [config.self.homeManagerModules.mightyiam];
}

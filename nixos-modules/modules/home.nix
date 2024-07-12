{config, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.users.mightyiam.imports = [
    ({osConfig, ...}: {home.stateVersion = osConfig.system.stateVersion;})
  ];
}

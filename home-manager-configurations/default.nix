{lib, self,...}: {
  imports = builtins.readDir ./.
  |> lib.filterAttrs (_: type: type == "directory")
  |> lib.mapAttrsToList (name: _: {
    perSystem = {pkgs, ...}: {
    flake.homeConfigurations.${name} = self.inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit self;};
      modules = [(./. + "/${name}")];
    };
    };
  });
}

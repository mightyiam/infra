{
  lib,
  inputs,
  self,
  ...
}: {
  imports = lib.pipe ./nixos-configurations [
    builtins.readDir
    lib.attrNames

    (map (hostname: {
      flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.mightyiam.imports = [
              inputs.self.homeManagerModules.mightyiam
            ];
          }
          (./nixos-configurations + "/${hostname}")
        ];
      };

      perSystem.checks."nixosConfigurations/${hostname}" =
        self
        .nixosConfigurations
        .${hostname}
        .config
        .system
        .build
        .toplevel;
    }))
  ];
}

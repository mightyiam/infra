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
        specialArgs = {inherit self;};
        modules = [(./nixos-configurations + "/${hostname}")];
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

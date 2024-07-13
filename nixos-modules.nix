{
  lib,
  inputs,
  ...
}: {
  imports = lib.pipe ./nixos-modules/hosts [
    builtins.readDir
    lib.attrNames

    (map (hostname: {
      flake.nixosModules.${hostname} = {
        imports = [
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.mightyiam.imports = [
              inputs.self.homeManagerModules.mightyiam
            ];
          }
          (./nixos-modules/hosts + "/${hostname}")
        ];
      };
    }))
  ];
}

{
  lib,
  inputs,
  ...
}: {
  flake.nixosModules = lib.pipe ./nixos-modules/hosts [
    builtins.readDir
    (lib.mapAttrs (hostname: _: {
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
    }))
  ];
}

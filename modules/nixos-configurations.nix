{
  lib,
  config,
  ...
}:
let
  prefix = "nixosConfigurations/";
in
{
  perSystem.files.files."README.md".parts.nixos-configurations =
    # markdown
    ''
      ## Configurations are declared by prefixing a module's name

      This spares me of some boilerplate.
      For example, see [`termitomyces/imports`](modules/termitomyces/imports.nix) module.

    '';

  flake = {
    nixosConfigurations =
      config.flake.modules.nixos or { }
      |> lib.filterAttrs (name: _module: lib.hasPrefix prefix name)
      |> lib.mapAttrs' (
        name: module:
        let
          hostName = lib.removePrefix prefix name;
        in
        {
          name = hostName;
          value = lib.nixosSystem {
            modules = [
              module
              { networking = { inherit hostName; }; }
            ];
          };
        }
      );
    checks =
      config.flake.nixosConfigurations
      |> lib.mapAttrsToList (
        name: nixos: {
          ${nixos.config.nixpkgs.hostPlatform.system} = {
            "${prefix}${name}" = nixos.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}

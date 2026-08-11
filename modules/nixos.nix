{
  config,
  lib,
  evalModulesModule,
  inputs,
  ...
}: {
  options.nixos = {
    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule ({name, ...}: {
          imports = [evalModulesModule];
          options.name = lib.mkOption {
            readOnly = true;
            type = lib.types.str;
            default = name;
          };
          config = {
            fn = import "${inputs.nixpkgs}/nixos/lib/eval-config.nix";
            args = {system = null;};
          };
        })
      );
    };
  };

  config = {
    flake = {
      nixosConfigurations = config.nixos.configurations |> lib.mapAttrs (name: {configuration, ...}: configuration);

      checks =
        config.nixos.configurations
        |> lib.mapAttrsToList (
          name: {configuration, ...}: {
            ${configuration.config.hardware.facter.report.system} = {
              "configurations:nixos:${name}" = configuration.config.system.build.toplevel;
            };
          }
        )
        |> lib.mkMerge;
    };

    nixos.modules.pc = {
      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 8192;
          qemu.options = [
            "-device virtio-balloon"
          ];
        };
      };
    };

    git.ignore = ["*.qcow2"];
  };
}

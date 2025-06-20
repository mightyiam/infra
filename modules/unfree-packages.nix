{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    text.readme.parts.unfree-packages = ''
      ## Unfree packages

      What Nixpkgs unfree packages are allowed is configured at the flake level via an option.
      That is then used in the configuration of Nixpkgs used in NixOS, Home Manager or elsewhere.
      See definition at [`unfree-packages.nix`](modules/unfree-packages.nix).
      See usage at [`steam.nix`](modules/steam.nix).
      Value of this option available as flake output:

      ```console
      $ nix eval .#meta.nixpkgs.allowedUnfreePackages
      [ "steam" "steam-unwrapped" "nvidia-x11" "nvidia-settings" ]
      ```

    '';

    flake = {
      modules =
        let
          predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
        in
        {
          nixos.pc.nixpkgs.config.allowUnfreePredicate = predicate;

          homeManager.base = args: {
            nixpkgs.config = lib.mkIf (!(args.hasGlobalPkgs or false)) {
              allowUnfreePredicate = predicate;
            };
          };
        };

      meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
    };
  };
}

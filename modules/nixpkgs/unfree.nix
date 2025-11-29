{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.singleLineStr;
    default = [ ];
  };

  config = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;

    text.readme.parts.unfree-packages = ''
      ## Unfree packages

      What Nixpkgs unfree packages are allowed is configured at the flake level via an option.
      That is then used in the configuration of Nixpkgs used in NixOS, Home Manager or elsewhere.
      See definition at [`nixpkgs/unfree.nix`](modules/nixpkgs/unfree.nix).
      See usage at [`steam.nix`](modules/steam.nix).
      Value of this option available as flake output:

      ```console
      $ nix eval .#meta.nixpkgs.allowedUnfreePackages
      [ "steam" "steam-unwrapped" "nvidia-x11" "nvidia-settings" ]
      ```

    '';

    flake.meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
  };
}

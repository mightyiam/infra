{ lib, config, ... }:
{
  options.nix.settings = {
    keep-outputs = lib.mkOption { type = lib.types.bool; };
    experimental-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [ ];
    };
    extra-system-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [ ];
    };
  };
  config = {
    nix.settings = {
      keep-outputs = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];
      extra-system-features = [ "recursive-nix" ];
    };
    flake.modules = {
      nixos.base.nix = {
        inherit (config.nix) settings;
      };

      homeManager.base.nix = {
        inherit (config.nix) settings;
      };

      nixOnDroid.base.nix.extraOptions =
        config.nix.settings
        |> lib.mapAttrsToList (name: value: "${name} = ${toString value}")
        |> lib.concatLines;
    };
  };
}

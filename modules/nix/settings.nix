{
  lib,
  config,
  ...
}: {
  options.nix.settings = {
    keep-outputs = lib.mkOption {type = lib.types.bool;};
    experimental-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [];
    };
    extra-system-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [];
    };
    trusted-users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
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
      extra-system-features = ["recursive-nix"];
      trusted-users = ["mightyiam"];
    };

    nixos.modules.base = {
      nix = {
        inherit (config.nix) settings;
      };
    };
  };
}

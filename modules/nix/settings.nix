{
  lib,
  config,
  ...
}: {
  options.nix.settings = {
    auto-allocate-uids = lib.mkOption {type = lib.types.bool;};
    extra-sandbox-paths = lib.mkOption {type = lib.types.listOf lib.types.str;};
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
      auto-allocate-uids = true;
      extra-sandbox-paths = ["/dev/net"];
      keep-outputs = true;
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "nix-command"
        "flakes"
        "recursive-nix"
      ];
      extra-system-features = [
        "recursive-nix"
        "uid-range"
      ];
      trusted-users = ["mightyiam"];
    };

    nixos.modules.base = {
      nix = {
        inherit (config.nix) settings;
      };
    };
  };
}

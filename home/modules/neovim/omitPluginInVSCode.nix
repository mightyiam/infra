let
  inherit
    (builtins)
    concatStringsSep
    ;

  omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
in
  plugin: config: {
    inherit plugin;
    optional = true;
    config = omitVIMLInVSCode (concatStringsSep "" [
      ":packadd "
      plugin.pname
      "\n"
      config
    ]);
  }

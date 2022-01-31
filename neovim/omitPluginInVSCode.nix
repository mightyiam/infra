let
  omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
in
plugin: config: {
  inherit plugin;
  optional = true;
  config = omitVIMLInVSCode (builtins.concatStringsSep "" [
    ":packadd "
    plugin.pname
    "\n"
    config
  ]);
}

{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.me = mkOption {
    type = types.str;
    default = "mightyiam";
  };
  config.users.users.${config.me} = {
    isNormalUser = true;
    initialPassword = "";
    extraGroups = ["wheel" "audio" "docker" "input"];
  };
  config.nix.settings.trusted-users = ["root" config.me];
}

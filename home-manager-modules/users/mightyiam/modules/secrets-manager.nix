{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = {
    programs.rbw = {
      enable = true;
      settings = {
        email = "mightyiampresence@gmail.com";
        pinentry = config.pinentry;
      };
    };
    home.packages = [ pkgs.rofi-rbw-wayland ];
  };
  options.secretsMenu = lib.mkOption {
    type = lib.types.path;
    default = lib.getExe pkgs.rofi-rbw-wayland;
  };
}

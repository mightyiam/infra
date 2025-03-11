{ lib, ... }:
{
  flake.modules.homeManager = {
    base =
      {
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
          xdg.configFile."rofi-rbw.rc".text = lib.generators.toINIWithGlobalSection { } {
            # https://github.com/fdw/rofi-rbw#configuration
            globalSection = { };
          };
        };
        options.secretsMenu = lib.mkOption {
          type = lib.types.path;
          default = lib.getExe pkgs.rofi-rbw-wayland;
        };
      };
    gui =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.rofi-rbw-wayland ];
      };
  };
}

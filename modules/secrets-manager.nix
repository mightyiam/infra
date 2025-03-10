{ lib, ... }:
{
  flake.modules.homeManager.home =
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
        home.packages = lib.mkIf config.gui.enable [ pkgs.rofi-rbw-wayland ];
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
}

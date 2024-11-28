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
    home.packages = lib.mkIf config.gui.enable [ pkgs.rofi-rbw-wayland ];
    xdg.configFile."rofi-rbw.rc".text = lib.generators.toINIWithGlobalSection { } {
      globalSection = {
        keybindings = lib.concatStringsSep "," [
          "Alt+1:type:username:tab:password"
          "Alt+2:type:username"
          "Alt+3:type:password"
          "Alt+4:type:totp"
          # "Alt+c:copy:password"
          "Alt+u:copy:username"
          # "Alt+t:copy:totp"
          "Alt+m::menu"
          "Alt+s:sync"
        ];
        menu-keybindings = lib.concatStringsSep "," [
          "Alt+t:type"
          # "Alt+c:copy"
        ];
      };
    };
  };
  options.secretsMenu = lib.mkOption {
    type = lib.types.path;
    default = lib.getExe pkgs.rofi-rbw-wayland;
  };
}

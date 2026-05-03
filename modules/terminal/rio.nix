{ lib, ... }:
{
  flake.modules.homeManager.gui = hmArgs: {
    programs.rio = {
      enable = true;
    };
    terminal = {
      path = lib.getExe hmArgs.config.programs.rio.package;
      desktopFileId = "rio.desktop";
    };
  };
}

{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    lib.mkIf config.gui.enable {
      home.packages = with pkgs; [ vlc ];
    };
}

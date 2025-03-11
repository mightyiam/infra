{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      config,
      ...
    }:
    lib.mkIf config.gui.enable {
      home.packages = with pkgs; [ tor-browser-bundle-bin ];
    };
}

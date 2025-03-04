{ lib, ... }:
{
  flake.modules.homeManager.anki =
    {
      pkgs,
      config,
      ...
    }:
    lib.mkIf config.gui.enable {
      home.packages = with pkgs; [ anki ];
    };
}

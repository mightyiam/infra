{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.gui.enable {
  home.packages = with pkgs; [
    anki
  ];
}

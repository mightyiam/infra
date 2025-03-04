{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkMerge [
  (lib.mkIf config.gui.enable {
    home.packages = with pkgs; [
      gimp
      inkscape
    ];
  })
]

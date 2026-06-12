{
  homeManager.modules.gui = {pkgs, ...}: {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.google-fonts
      pkgs.gucharmap
      pkgs.tlwg
      pkgs.uni
    ];
  };
}

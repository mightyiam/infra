{
  nixos.modules.pc = {pkgs, ...}: {
    fonts.packages = [
      pkgs.google-fonts
      pkgs.gucharmap
      pkgs.tlwg
      pkgs.uni
    ];
  };

  homeManager.modules.gui = {
    fonts.fontconfig.enable = true;
  };
}

{
  nixos.modules.pc = {pkgs, ...}: {
    fonts.packages = [
      pkgs.google-fonts
      pkgs.gucharmap
      pkgs.tlwg
    ];
  };

  homeManager.modules.gui = {
    fonts.fontconfig.enable = true;
  };
}

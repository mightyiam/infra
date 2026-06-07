{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      exiftool
      gimp-with-plugins
      imagemagick
      inkscape
      jpeginfo
      jpegoptim
    ];
  };
}

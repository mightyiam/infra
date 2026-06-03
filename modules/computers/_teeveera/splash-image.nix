{
  boot.loader.grub = {
    grub.splashImage = ./teeveera-splash-screen-1920x1080.png;
    grub.extraConfig = ''
      set color_normal=black/black
      set color_highlight=black/magenta
    '';
  };
}

{
  nixos.modules.bow = {
    services = {
      system76-scheduler.enable = true;
      desktopManager.cosmic.enable = true;
    };
  };
  users.bow.home.gui = {pkgs, ...}: {
    xdg.mimeApps.defaultApplicationPackages = [
      pkgs.cosmic-edit
      pkgs.loupe
    ];
  };
}
